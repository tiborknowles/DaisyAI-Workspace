# Copyright 2025 Google LLC
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#     http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.

variable "repository_owner" {
  description = "Owner of the GitHub repository"
  type        = string
}

variable "github_app_installation_id" {
  description = "GitHub App Installation ID"
  type        = string
}

variable "github_pat_secret_id" {
  description = "GitHub PAT secret id in Cloud Secret Manager"
  type        = string
  default     = "github-pat"
}

variable "connection_exists" {
  description = "Flag indicating if a Cloud Build connection already exists"
  type        = bool
  default     = false
}

variable "repository_exists" {
  description = "Flag indicating if the Git repository already exists"
  type        = bool
  default     = false
}
# --- ADD THIS ENTIRE BLOCK TO THE END OF THE FILE ---

variable "cicd_runner_project_id" {
  description = "The GCP project ID where the CI/CD resources will be created."
  type        = string
}

variable "region" {
  description = "The GCP region for deploying resources."
  type        = string
}

variable "host_connection_name" {
  description = "The name for the Cloud Build GitHub connection."
  type        = string
}

variable "project_name" {
  description = "The name of the agent project, used for resource naming."
  type        = string
}

variable "data_store_region" {
  description = "The region of the Vertex AI Search data store."
  type        = string
}

variable "repository_name" {
  description = "The name of the source code repository."
  type        = string
}

variable "pipeline_cron_schedule" {
  description = "The cron schedule for the pipeline."
  type        = string
}

variable "staging_project_id" {
  description = "The GCP project ID for the staging environment."
  type        = string
}

variable "prod_project_id" {
  description = "The GCP project ID for the production environment."
  type        = string
}
# --- ADD THIS ENTIRE BLOCK TO THE END OF THE FILE ---

variable "cicd_runner_project_id" {
  description = "The GCP project ID where the CI/CD resources will be created."
  type        = string
}

variable "region" {
  description = "The GCP region for deploying resources."
  type        = string
}

variable "host_connection_name" {
  description = "The name for the Cloud Build GitHub connection."
  type        = string
}

variable "project_name" {
  description = "The name of the agent project, used for resource naming."
  type        = string
}

variable "data_store_region" {
  description = "The region of the Vertex AI Search data store."
  type        = string
}

variable "repository_name" {
  description = "The name of the source code repository."
  type        = string
}

variable "pipeline_cron_schedule" {
  description = "The cron schedule for the pipeline."
  type        = string
}

variable "staging_project_id" {
  description = "The GCP project ID for the staging environment."
  type        = string
}

variable "prod_project_id" {
  description = "The GCP project ID for the production environment."
  type        = string
}