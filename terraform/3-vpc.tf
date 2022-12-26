resource "google_project_service" "this" {
  service = "compute.gooogleapis.com"
}

resource "google_project_service" "that" {
  service = "container.gooogleapis.com"
}

resource "google_compute_network" "this" {
  project                 = "gilad-dev-k8s"
  routing_mode = "REGIONAL"
  name                    = "giladtrachtenberg-vpc"
  auto_create_subnetworks = false
  mtu                     = 1460
  delete_default_routes_on_create = false

  depends_on = [
    google_project_service.this,
    google_project_service.that
  ]
}