/**
 * DaisyAI Agent Ecosystem - Central Variables Configuration
 * This file defines all variables used across the mono-repo infrastructure
 */

variable "project_id" {
  description = "The GCP project ID"
  type        = string
}

variable "region" {
  description = "The GCP region for resources"
  type        = string
  default     = "us-central1"
}

variable "zone" {
  description = "The GCP zone for resources"
  type        = string
  default     = "us-central1-a"
}

variable "environment" {
  description = "Environment (staging or production)"
  type        = string
  validation {
    condition     = contains(["staging", "production"], var.environment)
    error_message = "Environment must be either 'staging' or 'production'."
  }
}

variable "repository_name" {
  description = "Name of the GitHub repository"
  type        = string
  default     = "DaisyAI-Workspace"
}

variable "repository_owner" {
  description = "Owner of the GitHub repository"
  type        = string
}

variable "github_connection_name" {
  description = "Name of the Cloud Build GitHub connection"
  type        = string
  default     = "daisy-ai-github-connection"
}

variable "agents" {
  description = "Map of agent configurations"
  type = map(object({
    template = string
    port     = number
    enabled  = optional(bool, true)
  }))
  default = {}
}

variable "vertex_ai_location" {
  description = "Location for Vertex AI resources"
  type        = string
  default     = "us-central1"
}

variable "artifact_registry_location" {
  description = "Location for Artifact Registry"
  type        = string
  default     = "us-central1"
}

variable "cloud_build_timeout" {
  description = "Timeout for Cloud Build jobs in seconds"
  type        = string
  default     = "3600s"
}

variable "enable_monitoring" {
  description = "Enable monitoring and observability features"
  type        = bool
  default     = true
}

variable "enable_security_scanning" {
  description = "Enable security scanning for containers"
  type        = bool
  default     = true
}

variable "notification_channels" {
  description = "List of notification channels for monitoring alerts"
  type        = list(string)
  default     = []
}

variable "labels" {
  description = "Labels to apply to all resources"
  type        = map(string)
  default = {
    project     = "daisy-ai"
    managed-by  = "terraform"
    environment = "unknown"
  }
} 