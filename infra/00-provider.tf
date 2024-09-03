provider "google" {
  project      = var.gcp_project_id
  region       = var.gcp_region
  zone         = var.gcp_zone
#   access_token = var.service_account_token
  credentials = "../shortlet-sa.json"
}

provider "kubernetes" {
  host                   = google_container_cluster.primary.endpoint
#   token                  = var.service_account_token
#   cluster_ca_certificate = base64decode(google_container_cluster.primary.master_auth.0.cluster_ca_certificate)
}

terraform {
  required_providers {
    google = {
      source  = "hashicorp/google"
      version = "~> 5.0"
    }
  }
}