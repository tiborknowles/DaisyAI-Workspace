# Project name used for resource naming
project_name = "daisy-knowledge"

# Your Production Google Cloud project id
prod_project_id = "daisy-pipeline-validation-prod"

# Your Staging / Test Google Cloud project id
staging_project_id = "daisy-pipeline-validation"

# Your Google Cloud project ID that will be used to host the Cloud Build pipelines.
# Using staging as CI/CD runner as per Google Agent Starter Pack best practices
cicd_runner_project_id = "daisy-pipeline-validation-prod"

# Name of the host connection you created in Cloud Build
host_connection_name = "git-daisy-sandbox-validation"

# Name of the repository you added to Cloud Build
repository_name = "daisy-sandbox-validation"

# The Google Cloud region you will use to deploy the infrastructure
region = "us-central1"
pipeline_cron_schedule = "0 0 * * 0"
#The value can only be one of "global", "us" and "eu".
data_store_region = "us"
repository_owner = "tiborknowles"
github_app_installation_id = "70463961"
github_pat_secret_id = "git-daisy-sandbox-validation-github-oauthtoken-950b9a"
connection_exists = true
repository_exists = true
