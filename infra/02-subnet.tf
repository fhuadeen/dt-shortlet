resource "google_compute_subnetwork" "subnetwork" {
  name          = "shortlet-subnet"
  ip_cidr_range = "10.0.0.0/16"
  network       = google_compute_network.vpc_network.id
  region        = var.gcp_region
}