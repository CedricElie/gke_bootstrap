# Create VPC Network
resource "google_compute_network" "gke_network" {
  project                 = var.project_id
  name                    = "gke-vpc"
  auto_create_subnetworks = false
  routing_mode            = "REGIONAL"

  depends_on = [google_project_service.required_services]
}

# Create Subnet for GKE with secondary ranges for pods and services
resource "google_compute_subnetwork" "gke_subnet" {
  project       = var.project_id
  name          = "gke-subnet"
  ip_cidr_range = "10.0.0.0/24"
  region        = var.region
  network       = google_compute_network.gke_network.id

  # Secondary IP range for pods
  secondary_ip_range {
    range_name    = "pods"
    ip_cidr_range = "10.4.0.0/14"
  }

  # Secondary IP range for services
  secondary_ip_range {
    range_name    = "services"
    ip_cidr_range = "10.8.0.0/20"
  }

  depends_on = [google_compute_network.gke_network]
}
