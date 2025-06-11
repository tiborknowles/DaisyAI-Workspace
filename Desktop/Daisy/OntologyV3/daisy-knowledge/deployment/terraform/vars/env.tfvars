# Project name used for resource naming
project_name = "daisy-knowledge"

# Your Production Google Cloud project id
prod_project_id = "daisy-ai-production"

# Your Staging / Test Google Cloud project id
staging_project_id = "daisy-ai-staging"

# Your Google Cloud project ID that will be used to host the Cloud Build pipelines.
# Using staging as CI/CD runner as per Google Agent Starter Pack best practices
cicd_runner_project_id = "daisy-ai-staging"

# Name of the host connection you created in Cloud Build
host_connection_name = "daisy-github-connection"

# Name of the repository you added to Cloud Build
repository_name = "Daisy"

# The Google Cloud region you will use to deploy the infrastructure
region = "us-central1"
pipeline_cron_schedule = "0 0 * * 0"
#The value can only be one of "global", "us" and "eu".
data_store_region = "us"
