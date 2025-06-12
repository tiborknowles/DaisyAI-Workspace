terraform {
  backend "gcs" {
    bucket = "daisy-pipeline-validation-prod-terraform-state"
    prefix = "daisy-sandbox-validation/prod"
  }
}
