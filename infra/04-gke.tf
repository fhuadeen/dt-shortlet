resource "google_container_cluster" "primary" {
  name               = var.k8s_cluster_name
  location           = var.gcp_zone
  initial_node_count = var.init_node_count
  network            = google_compute_network.vpc_network.id
  subnetwork         = google_compute_subnetwork.subnetwork.id

  master_auth {
    # username = ""
    # password = ""
    client_certificate_config {
      issue_client_certificate = false
    }
  }

  node_config {
    machine_type = "e2-medium"

    oauth_scopes = [
      "https://www.googleapis.com/auth/cloud-platform",
    ]
  }

#   ip_allocation_policy {
#     use_ip_aliases = true
#   }

  # Enable the NAT Gateway for egress traffic
#   add_cluster_firewall_rules = true
}

output "kubernetes_cluster_name" {
  value = google_container_cluster.primary.name
}
