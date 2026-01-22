# Enable required GCP services
resource "google_project_service" "required_services" {
  for_each = toset([
    "container.googleapis.com",            # Kubernetes Engine API
    "compute.googleapis.com",              # Compute Engine API
    "cloudresourcemanager.googleapis.com", # Cloud Resource Manager API
    "servicenetworking.googleapis.com",    # Service Networking API
    "iam.googleapis.com",                  # IAM API
  ])

  project = var.project_id
  service = each.value

  disable_on_destroy = false
}
