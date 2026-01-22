# Create service account for GKE nodes
resource "google_service_account" "gke_nodes" {
  project      = var.project_id
  account_id   = var.gke_service_account_name
  display_name = "GKE Nodes Service Account"
  description  = "Service account for GKE Autopilot cluster nodes"

  depends_on = [google_project_service.required_services]
}

# IAM Roles for GKE nodes service account
resource "google_project_iam_member" "gke_nodes_roles" {
  for_each = toset([
    "roles/logging.logWriter",                   # Write logs
    "roles/monitoring.metricWriter",             # Write metrics
    "roles/monitoring.viewer",                   # View monitoring data
    "roles/stackdriver.resourceMetadata.writer", # Write resource metadata
  ])

  project = var.project_id
  role    = each.value
  member  = "serviceAccount:${google_service_account.gke_nodes.email}"

  depends_on = [google_service_account.gke_nodes]
}

# Create service account for workloads (Workload Identity)
resource "google_service_account" "gke_workload" {
  project      = var.project_id
  account_id   = "gke-workload"
  display_name = "GKE Workload Service Account"
  description  = "Service account for GKE Autopilot workloads with Workload Identity"

  depends_on = [google_project_service.required_services]
}

# Create service account for Artifact Registry
resource "google_service_account" "artifact_registry_pusher" {
  project      = var.project_id
  account_id   = "artifact-registry-pusher"
  display_name = "Artifact Registry Pusher Service Account"
  description  = "Service account for pushing Docker images to Artifact Registry"

  depends_on = [google_project_service.required_services]
}

# IAM Role for Artifact Registry pusher (write access)
resource "google_project_iam_member" "artifact_registry_pusher_role" {
  project = var.project_id
  role    = "roles/artifactregistry.writer"
  member  = "serviceAccount:${google_service_account.artifact_registry_pusher.email}"

  depends_on = [google_service_account.artifact_registry_pusher]
}

# Create service account for Artifact Registry reader
resource "google_service_account" "artifact_registry_reader" {
  project      = var.project_id
  account_id   = "artifact-registry-reader"
  display_name = "Artifact Registry Reader Service Account"
  description  = "Service account for pulling Docker images from Artifact Registry"

  depends_on = [google_project_service.required_services]
}

# IAM Role for Artifact Registry reader (read access)
resource "google_project_iam_member" "artifact_registry_reader_role" {
  project = var.project_id
  role    = "roles/artifactregistry.reader"
  member  = "serviceAccount:${google_service_account.artifact_registry_reader.email}"

  depends_on = [google_service_account.artifact_registry_reader]
}

# IAM Role for GKE workload to read from Artifact Registry
resource "google_project_iam_member" "gke_workload_artifact_registry_reader" {
  project = var.project_id
  role    = "roles/artifactregistry.reader"
  member  = "serviceAccount:${google_service_account.gke_workload.email}"

  depends_on = [google_service_account.gke_workload]
}
