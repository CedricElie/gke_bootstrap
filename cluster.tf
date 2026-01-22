# Create GKE Autopilot Cluster
resource "google_container_cluster" "gke_autopilot" {
  project  = var.project_id
  name     = "gke-autopilot-cluster"
  location = var.region

  # Use Autopilot mode
  enable_autopilot = true

  # Network configuration
  network    = google_compute_network.gke_network.name
  subnetwork = google_compute_subnetwork.gke_subnet.name

  # IP allocation policy for secondary ranges
  ip_allocation_policy {
    cluster_secondary_range_name  = "pods"
    services_secondary_range_name = "services"
  }

  # Workload Identity enabled by default in Autopilot
  workload_identity_config {
    workload_pool = "${var.project_id}.svc.id.goog"
  }

  # Logging and Monitoring
  logging_service    = "logging.googleapis.com/kubernetes"
  monitoring_service = "monitoring.googleapis.com/kubernetes"

  # Maintenance window
  maintenance_policy {
    daily_maintenance_window {
      start_time = "03:00"
    }
  }

  depends_on = [
    google_compute_subnetwork.gke_subnet,
    google_service_account.gke_nodes,
    google_compute_firewall.gke_internal,
    google_compute_firewall.gke_control_plane
  ]
}
