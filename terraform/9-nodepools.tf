resource "google_service_account" "this" {
  account_id = "kubernetes"
}

resource "google_container_node_pool" "this" {
  name = "general"
  cluster = google_container_cluster.this.id
  management {
    auto_repair = true
    auto_upgradce = true
  }
  
  autoscaling {
    min_node_count = 0
    max_node_count = 3
  }

  node_config {
    preemptible = true 
    machine_type = "e2-medium"
  }

  labels {
    team = "devops"
  }

  service_account = google.service_account.kubernetes.email
  oauth_scopes = ["https://www.googleapis.com/auth/cloud-platform"]
}

resource "google_container_node_pool" "that" {
  name = "general"
  cluster = google_container_cluster.this.id
  node_count = 2
  management {
    auto_repair = true
    auto_upgradce = true
  }
  node_config {
    preemptible = false
    machine_type = "e2-large"
  }
  labels {
    role = "general"
  }
  service_account = google.service_account.kubernetes.email
  oauth_scopes = ["https://www.googleapis.com/auth/cloud-platform"]

  taints {
    key = "instance_type"
    value = "spot"
    effect = "NO_SCHEDULE"
  }
}