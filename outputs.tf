output "gke_nodes_service_account_email" {
  description = "Email address of the GKE nodes service account"
  value       = google_service_account.gke_nodes.email
}

output "gke_nodes_service_account_id" {
  description = "ID of the GKE nodes service account"
  value       = google_service_account.gke_nodes.unique_id
}

output "gke_workload_service_account_email" {
  description = "Email address of the GKE workload service account"
  value       = google_service_account.gke_workload.email
}

output "enabled_services" {
  description = "List of enabled GCP services"
  value       = [for service in google_project_service.required_services : service.service]
}

output "vpc_network_id" {
  description = "ID of the GKE VPC network"
  value       = google_compute_network.gke_network.id
}

output "vpc_network_name" {
  description = "Name of the GKE VPC network"
  value       = google_compute_network.gke_network.name
}

output "subnet_id" {
  description = "ID of the GKE subnet"
  value       = google_compute_subnetwork.gke_subnet.id
}

output "subnet_name" {
  description = "Name of the GKE subnet"
  value       = google_compute_subnetwork.gke_subnet.name
}

output "pods_secondary_range" {
  description = "Secondary IP range for pods"
  value       = "10.4.0.0/14"
}

output "services_secondary_range" {
  description = "Secondary IP range for services"
  value       = "10.8.0.0/20"
}

output "gke_cluster_name" {
  description = "Name of the GKE Autopilot cluster"
  value       = google_container_cluster.gke_autopilot.name
}

output "gke_cluster_endpoint" {
  description = "Endpoint of the GKE Autopilot cluster"
  value       = google_container_cluster.gke_autopilot.endpoint
  sensitive   = true
}

output "gke_cluster_ca_certificate" {
  description = "CA certificate of the GKE Autopilot cluster"
  value       = google_container_cluster.gke_autopilot.master_auth[0].cluster_ca_certificate
  sensitive   = true
}

output "gke_cluster_location" {
  description = "Location of the GKE Autopilot cluster"
  value       = google_container_cluster.gke_autopilot.location
}

output "artifact_registry_repository_name" {
  description = "Name of the Artifact Registry Docker repository"
  value       = google_artifact_registry_repository.docker_repo.name
}

output "artifact_registry_repository_id" {
  description = "ID of the Artifact Registry Docker repository"
  value       = google_artifact_registry_repository.docker_repo.repository_id
}

output "artifact_registry_repository_url" {
  description = "URL of the Artifact Registry Docker repository"
  value       = "${var.region}-docker.pkg.dev/${var.project_id}/${google_artifact_registry_repository.docker_repo.repository_id}"
}

output "artifact_registry_location" {
  description = "Location of the Artifact Registry repository"
  value       = google_artifact_registry_repository.docker_repo.location
}

output "artifact_registry_pusher_email" {
  description = "Email of the service account for pushing images to Artifact Registry"
  value       = google_service_account.artifact_registry_pusher.email
}

output "artifact_registry_reader_email" {
  description = "Email of the service account for pulling images from Artifact Registry"
  value       = google_service_account.artifact_registry_reader.email
}
