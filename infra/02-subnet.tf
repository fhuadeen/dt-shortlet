resource "google_compute_subnetwork" "subnetwork_private" {
  name                     = "shortlet-subnet"
  ip_cidr_range            = "10.0.0.0/16"
  network                  = google_compute_network.vpc_network.id
  region                   = var.gcp_region
  private_ip_google_access = true

  # for k8s pods
  secondary_ip_range {
    range_name    = "pod-range"
    ip_cidr_range = "10.20.0.0/14"
  }

  # for k8s services
  secondary_ip_range {
    range_name    = "service-range"
    ip_cidr_range = "10.43.0.0/20"
  }
}