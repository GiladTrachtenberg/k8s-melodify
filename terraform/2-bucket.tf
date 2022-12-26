resource "google_storage_bucket" "static-site" {
  name          = "giladtrachtenberg-tf-state-staging"
  location      = "ME"
  force_destroy = true

  versioning {
    enabled = true
  }

  uniform_bucket_level_access = true
}