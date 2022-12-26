resource "google_container_cluster" "this" {
  name = "primary"
  location = "me-west1"
  remove_default_node_pool = true
  initial_node_count = 1
  network = google_compute_network.this.self_link
  subnetwork = google_compute_subnetwork.this.self_link
  networking_mode = "VPC_NATIVE"

  node_locations = [ "me-west1" ]
  addons_config {
    http_load_balancing {
      disabled = true
    }
    horizontal_pod_autoscaling { 
      disabled = false
     }
    }

  release_channel {
    channel = "REGULAR"
  }

  workload_identity_config {
    workload_pool = "gilad-dev-k8s.svc.id.goog"
  }

  ip_allocation_policy {
    cluster_secondary_range_name = "k8s-pod-range"
    services_secondary_range_name = "k8s-service-range"
  }

  private_cluster_config {
    enable_private_nodes = true
    enable_private_endpoint = false
    master_ipv4_cidr_block = "172.16.0.0/29"
  }

  master_authorized_networks_config {
    cidr_blocks {
        cidr_block = "10.0.0.0/28"
        display_name = "private-sb-access"
    }
  }
}

