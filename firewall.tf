# Firewall rule: Allow internal communication within the VPC
resource "google_compute_firewall" "gke_internal" {
  project = var.project_id
  name    = "gke-allow-internal"
  network = google_compute_network.gke_network.name

  allow {
    protocol = "tcp"
    ports    = ["0-65535"]
  }

  allow {
    protocol = "udp"
    ports    = ["0-65535"]
  }

  allow {
    protocol = "icmp"
  }

  source_ranges = [
    "10.0.0.0/24", # Subnet CIDR
    "10.4.0.0/14", # Pods CIDR
    "10.8.0.0/20"  # Services CIDR
  ]

  depends_on = [google_compute_subnetwork.gke_subnet]
}

# Firewall rule: Allow SSH (for debugging - optional)
resource "google_compute_firewall" "gke_ssh" {
  project = var.project_id
  name    = "gke-allow-ssh"
  network = google_compute_network.gke_network.name

  allow {
    protocol = "tcp"
    ports    = ["22"]
  }

  source_ranges = ["0.0.0.0/0"]

  depends_on = [google_compute_network.gke_network]
}

# Firewall rule: Allow health checks from Google Cloud
resource "google_compute_firewall" "gke_health_checks" {
  project = var.project_id
  name    = "gke-allow-health-checks"
  network = google_compute_network.gke_network.name

  allow {
    protocol = "tcp"
  }

  source_ranges = [
    "35.191.0.0/16", # Google Cloud Health Checks
    "130.211.0.0/22" # Google Cloud Health Checks
  ]

  depends_on = [google_compute_network.gke_network]
}

# Firewall rule: Allow GKE control plane to nodes
resource "google_compute_firewall" "gke_control_plane" {
  project = var.project_id
  name    = "gke-allow-control-plane"
  network = google_compute_network.gke_network.name

  allow {
    protocol = "tcp"
    ports    = ["443", "10250"]
  }

  source_ranges = ["0.0.0.0/0"] # GKE control plane ranges
  target_tags   = ["gke-node"]

  depends_on = [google_compute_network.gke_network]
}
