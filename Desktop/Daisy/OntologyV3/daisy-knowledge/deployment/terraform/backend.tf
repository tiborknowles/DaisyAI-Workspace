terraform {
  backend "gcs" {
    bucket = "daisy-ai-staging-terraform-state"
    prefix = "daisy-knowledge/prod"
  }
}
