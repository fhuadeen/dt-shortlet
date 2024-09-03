resource "google_container_cluster" "primary" {
  name                     = var.k8s_cluster_name
  location                 = var.gcp_zone # deploy a zonal cluster to reduce cost
  initial_node_count       = var.init_node_count
  network                  = google_compute_network.vpc_network.id
  subnetwork               = google_compute_subnetwork.subnetwork_private.id
  remove_default_node_pool = true # delete default node pool
  logging_service          = "logging.googleapis.com/kubernetes"
  monitoring_service       = "monitoring.googleapis.com/kubernetes"
  networking_mode          = "VPC_NATIVE"

  # master_auth {
  #   # username = ""
  #   # password = ""
  #   client_certificate_config {
  #     issue_client_certificate = false
  #   }
  # }

  # for multi-zonal cluster
  node_locations = [
    "us-central1-b"
  ]

  addons_config {
    http_load_balancing {
      disabled = true
    }
    horizontal_pod_autoscaling {
      disabled = true
    }
  }

  # node_config {
  #   machine_type = "e2-medium"

  #   oauth_scopes = [
  #     "https://www.googleapis.com/auth/cloud-platform",
  #   ]
  # }

  # service and pod IP ranges
  ip_allocation_policy {
    cluster_secondary_range_name  = "pod-range"
    services_secondary_range_name = "service-range"
  }

  private_cluster_config {
    enable_private_nodes    = true
    enable_private_endpoint = false
    master_ipv4_cidr_block  = "172.16.0.0/28"
  }

  # Enable the NAT Gateway for egress traffic
  #   add_cluster_firewall_rules = true
}

output "kubernetes_cluster_name" {
  value = google_container_cluster.primary.name
}
