resource "google_compute_subnetwork" "this" {
  name = "private"
  ip_cidr_range = "10.0.0.0/28"
  region = "me-west1"
  network = google_compute_network.this.id
  private_ip_google_access = true 

  secondary_ip_range {
    range_name = "k8s-pod-range"
    ip_cidr_range = "10.18.0.0/28"
  }
  secondary_ip_range {
    range_name = "k8s-service-range"
    ip_cidr_range = "10.52.0.0/27"
  }
}