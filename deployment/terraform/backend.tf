terraform {
  backend "gcs" {
    bucket = "daisy-ai-production-terraform-state"
    prefix = "daisy-knowledge/prod"
  }
}
