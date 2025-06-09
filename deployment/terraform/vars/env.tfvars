# Project name used for resource naming
project_name = "daisy-knowledge"

# Your Production Google Cloud project id
prod_project_id = "daisy-ai-production"

# Your Staging / Test Google Cloud project id
staging_project_id = "daisy-ai-staging"

# Your Google Cloud project ID that will be used to host the Cloud Build pipelines.
cicd_runner_project_id = "daisy-ai-production"

# Name of the host connection you created in Cloud Build
host_connection_name = "git-daisy-knowledge"

# Name of the repository you added to Cloud Build
repository_name = "daisy-knowledge"

# The Google Cloud region you will use to deploy the infrastructure
region = "us-central1"
pipeline_cron_schedule = "0 0 * * 0"
#The value can only be one of "global", "us" and "eu".
data_store_region = "us"
repository_owner = "tiborknowles"
github_app_installation_id = "70463961"
github_pat_secret_id = "git-daisy-knowledge-github-oauthtoken-812a98"
connection_exists = true
repository_exists = true
