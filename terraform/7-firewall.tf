resource "google_compute_firewall" "this" {
  name = "allow-ssh"
  network = google_compute_network.this.id

  allow {
    protocol = "tcp"
    ports = ["22"]
  }
  
  source_ranges = ["0.0.0.0/0"]
}