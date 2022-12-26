resource "google_compute_router" "this" {
  name = "router"
  region = "me-west1"
  network = google_compute_network.this.id
}