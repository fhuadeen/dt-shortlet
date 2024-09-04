resource "google_project_service" "compute_api" {
  service                    = "compute.googleapis.com"
  disable_on_destroy         = false
  disable_dependent_services = true

  lifecycle {
    prevent_destroy = true
  }
}

resource "google_project_service" "container_api" {
  service                    = "container.googleapis.com"
  disable_on_destroy         = false
  disable_dependent_services = true

  lifecycle {
    prevent_destroy = true
  }
}

resource "google_compute_network" "vpc_network" {
  name                    = "shortlet-vpc"
  auto_create_subnetworks = false #manually define our own subnet

  depends_on = [
    google_project_service.compute_api,
    google_project_service.container_api
  ]
}
