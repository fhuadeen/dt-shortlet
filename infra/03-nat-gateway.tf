resource "google_compute_router" "nat_router" {
  name    = "shorlet-router"
  network = google_compute_network.vpc_network.id
  region  = var.gcp_region
}

resource "google_compute_router_nat" "nat_gw" {
  name                               = "shortlet-nat"
  router                             = google_compute_router.nat_router.id
  region                             = var.gcp_region
  nat_ip_allocate_option             = "AUTO_ONLY"
  source_subnetwork_ip_ranges_to_nat = "ALL_SUBNETWORKS_ALL_IP_RANGES"
}
