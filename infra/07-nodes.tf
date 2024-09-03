# # https://registry.terraform.io/providers/hashicorp/google/latest/docs/resources/google_service_account
# resource "google_service_account" "kubernetes" {
#   account_id = "kubernetes"
# }

# https://registry.terraform.io/providers/hashicorp/google/latest/docs/resources/container_node_pool
resource "google_container_node_pool" "shoplet_node" {
  name       = "shoplet-node"
  cluster    = google_container_cluster.primary.id
  node_count = 1

  management {
    auto_repair  = true
    auto_upgrade = true
  }

  node_config {
    preemptible  = false
    machine_type = "e2-small"

    labels = {
      role = "shoplet-apps"
    }

    service_account = google_service_account.gke_sa.email
    oauth_scopes = [
      "https://www.googleapis.com/auth/cloud-platform"
    ]
  }
}
