/**
 * DaisyAI Agent Ecosystem - Main Terraform Configuration
 * Centralized infrastructure management for all 11 agents using for_each
 */

terraform {
  required_version = ">= 1.0"
  required_providers {
    google = {
      source  = "hashicorp/google"
      version = "~> 5.0"
    }
    google-beta = {
      source  = "hashicorp/google-beta"
      version = "~> 5.0"
    }
  }
  
  # backend "gcs" {
  #   bucket = "daisy-ai-staging-tf-state-1749803208"
  #   prefix = "terraform/state"
  # }
}

# Configure the Google Cloud Provider
provider "google" {
  project = var.project_id
  region  = var.region
}

provider "google-beta" {
  project = var.project_id
  region  = var.region
}

# Data source for current project
data "google_project" "current" {}

# Create GCS bucket for Terraform state (if it doesn't exist)
resource "google_storage_bucket" "terraform_state" {
  name     = "${var.project_id}-terraform-state"
  location = var.region
  
  # Prevent accidental deletion
  lifecycle {
    prevent_destroy = true
  }
  
  versioning {
    enabled = true
  }
  
  labels = merge(var.labels, {
    purpose = "terraform-state"
  })
}

# Enable required APIs
resource "google_project_service" "required_apis" {
  for_each = toset([
    "aiplatform.googleapis.com",
    "cloudbuild.googleapis.com",
    "run.googleapis.com",
    "artifactregistry.googleapis.com",
    "secretmanager.googleapis.com",
    "monitoring.googleapis.com",
    "logging.googleapis.com",
    "cloudtrace.googleapis.com",
    "bigquery.googleapis.com",
    "discoveryengine.googleapis.com"
  ])
  
  service = each.value
  project = var.project_id
  
  disable_dependent_services = false
  disable_on_destroy        = false
}

# Artifact Registry for container images
resource "google_artifact_registry_repository" "agents" {
  repository_id = "daisy-agents"
  format        = "DOCKER"
  location      = var.artifact_registry_location
  description   = "Container registry for DaisyAI agents"
  
  labels = merge(var.labels, {
    purpose = "agent-containers"
  })
  
  depends_on = [google_project_service.required_apis]
}

# Create service accounts for each agent
resource "google_service_account" "agent_service_accounts" {
  for_each = var.agents
  
  account_id   = "${replace(each.key, "_", "-")}-sa"
  display_name = "Service Account for ${each.key}"
  description  = "Service account for DaisyAI ${each.key} agent"
  project      = var.project_id
}

# Grant necessary roles to agent service accounts
resource "google_project_iam_member" "agent_permissions" {
  for_each = {
    for pair in setproduct(keys(var.agents), [
      "roles/aiplatform.user",
      "roles/storage.admin",
      "roles/secretmanager.accessor",
      "roles/logging.logWriter",
      "roles/monitoring.metricWriter",
      "roles/cloudtrace.agent",
      "roles/run.invoker"
    ]) : "${pair[0]}-${pair[1]}" => {
      agent = pair[0]
      role  = pair[1]
    }
  }
  
  project = var.project_id
  role    = each.value.role
  member  = "serviceAccount:${google_service_account.agent_service_accounts[each.value.agent].email}"
}

# Cloud Run services for each agent
resource "google_cloud_run_v2_service" "agent_services" {
  for_each = var.agents
  
  name     = each.key
  location = var.region
  project  = var.project_id
  
  template {
    service_account = google_service_account.agent_service_accounts[each.key].email
    
    containers {
      image = "${var.artifact_registry_location}-docker.pkg.dev/${var.project_id}/daisy-agents/${each.key}:latest"
      
      ports {
        container_port = each.value.port
      }
      
      env {
        name  = "PORT"
        value = tostring(each.value.port)
      }
      
      env {
        name  = "PROJECT_ID"
        value = var.project_id
      }
      
      env {
        name  = "REGION"
        value = var.region
      }
      
      env {
        name  = "AGENT_NAME"
        value = each.key
      }
      
      resources {
        limits = {
          cpu    = "2"
          memory = "4Gi"
        }
      }
    }
    
    scaling {
      min_instance_count = 0
      max_instance_count = 10
    }
  }
  
  traffic {
    percent = 100
    type    = "TRAFFIC_TARGET_ALLOCATION_TYPE_LATEST"
  }
  
  labels = merge(var.labels, {
    agent = each.key
    template = each.value.template
  })
  
  depends_on = [
    google_project_service.required_apis,
    google_artifact_registry_repository.agents
  ]
}

# Vertex AI endpoints for each agent (for custom model deployment)
resource "google_vertex_ai_endpoint" "agent_endpoints" {
  for_each = {
    for k, v in var.agents : k => v
    if v.template == "agentic_rag" || v.template == "langgraph_base_react"
  }
  
  name         = "${each.key}-endpoint"
  display_name = "Vertex AI Endpoint for ${each.key}"
  description  = "Vertex AI endpoint for DaisyAI ${each.key} agent"
  location     = var.vertex_ai_location
  project      = var.project_id
  
  labels = merge(var.labels, {
    agent = each.key
    purpose = "model-serving"
  })
  
  depends_on = [google_project_service.required_apis]
}

# Cloud Build triggers for CI/CD
resource "google_cloudbuild_trigger" "agent_triggers" {
  for_each = var.agents
  
  name        = "${each.key}-trigger"
  description = "Build and deploy trigger for ${each.key} agent"
  project     = var.project_id
  
  github {
    owner = var.repository_owner
    name  = var.repository_name
    push {
      branch = "^main$"
    }
  }
  
  included_files = ["${each.key}/**"]
  
  build {
    step {
      name = "gcr.io/cloud-builders/docker"
      args = [
        "build",
        "-t", "${var.artifact_registry_location}-docker.pkg.dev/${var.project_id}/daisy-agents/${each.key}:$COMMIT_SHA",
        "-t", "${var.artifact_registry_location}-docker.pkg.dev/${var.project_id}/daisy-agents/${each.key}:latest",
        "${each.key}/"
      ]
    }
    
    step {
      name = "gcr.io/cloud-builders/docker"
      args = [
        "push",
        "${var.artifact_registry_location}-docker.pkg.dev/${var.project_id}/daisy-agents/${each.key}:$COMMIT_SHA"
      ]
    }
    
    step {
      name = "gcr.io/cloud-builders/docker"
      args = [
        "push", 
        "${var.artifact_registry_location}-docker.pkg.dev/${var.project_id}/daisy-agents/${each.key}:latest"
      ]
    }
    
    step {
      name = "gcr.io/cloud-builders/gcloud"
      args = [
        "run", "deploy", each.key,
        "--image", "${var.artifact_registry_location}-docker.pkg.dev/${var.project_id}/daisy-agents/${each.key}:$COMMIT_SHA",
        "--region", var.region,
        "--service-account", google_service_account.agent_service_accounts[each.key].email,
        "--allow-unauthenticated"
      ]
    }
  }
  
  service_account = google_service_account.cloudbuild.email
  
  depends_on = [
    google_project_service.required_apis,
    google_artifact_registry_repository.agents
  ]
}

# Cloud Build service account
resource "google_service_account" "cloudbuild" {
  account_id   = "daisy-cloudbuild"
  display_name = "DaisyAI Cloud Build Service Account"
  description  = "Service account for Cloud Build operations"
  project      = var.project_id
}

# Grant Cloud Build necessary permissions
resource "google_project_iam_member" "cloudbuild_permissions" {
  for_each = toset([
    "roles/cloudbuild.builds.builder",
    "roles/run.developer",
    "roles/iam.serviceAccountUser",
    "roles/artifactregistry.writer",
    "roles/aiplatform.user"
  ])
  
  project = var.project_id
  role    = each.value
  member  = "serviceAccount:${google_service_account.cloudbuild.email}"
}

# Monitoring and alerting
resource "google_monitoring_notification_channel" "email" {
  count = length(var.notification_channels) > 0 ? 1 : 0
  
  display_name = "DaisyAI Email Notifications"
  type         = "email"
  
  labels = {
    email_address = var.notification_channels[0]
  }
  
  depends_on = [google_project_service.required_apis]
}

# Outputs for reference
output "agent_service_urls" {
  description = "URLs of deployed agent services"
  value = {
    for k, v in google_cloud_run_v2_service.agent_services : k => v.uri
  }
}

output "vertex_ai_endpoints" {
  description = "Vertex AI endpoints for agents"
  value = {
    for k, v in google_vertex_ai_endpoint.agent_endpoints : k => v.name
  }
}

output "artifact_registry_url" {
  description = "Artifact Registry repository URL"
  value       = google_artifact_registry_repository.agents.name
} 