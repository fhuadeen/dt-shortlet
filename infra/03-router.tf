resource "google_compute_router" "nat_router" {
  name    = "shorlet-router"
  network = google_compute_network.vpc_network.id
  region  = var.gcp_region
}