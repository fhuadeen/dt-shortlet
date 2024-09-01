resource "google_compute_network" "vpc_network" {
  name                    = "shortlet-vpc"
  auto_create_subnetworks = false
}
