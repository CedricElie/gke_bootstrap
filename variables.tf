variable "project_id" {
  description = "GCP Project ID"
  type        = string
}

variable "region" {
  description = "GCP Region"
  type        = string
  default     = "us-central1"
}

variable "gke_service_account_name" {
  description = "Name of the service account for GKE nodes"
  type        = string
  default     = "gke-nodes"
}

variable "environment" {
  description = "Environment name"
  type        = string
  default     = "production"
}
