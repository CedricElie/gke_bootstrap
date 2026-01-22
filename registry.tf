# Enable Artifact Registry API
resource "google_project_service" "artifact_registry_api" {
  project = var.project_id
  service = "artifactregistry.googleapis.com"

  disable_on_destroy = false
}

# Create Artifact Registry Repository for Docker images
resource "google_artifact_registry_repository" "docker_repo" {
  project      = var.project_id
  location     = var.region
  repository_id = "gke-docker-repo"
  description  = "Docker repository for GKE Autopilot cluster"
  format       = "DOCKER"

  depends_on = [google_project_service.artifact_registry_api]
}
