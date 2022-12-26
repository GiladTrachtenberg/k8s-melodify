provider "google" {
  project     = "gilad-dev-k8s"
  region      = "me-west1"
}

terraform {
  backend "gcs" {
    bucket = "giladtrachtenberg-tf-state-staging"
    prefix = "terraform/state"
  }
  required_providers {
    google = {
        source = "hashicorp/google"
        version = "~> 4.0"
    }
  }
}   