resource "google_compute_firewall" "gke_deny_ssh" {
  name    = "deny-ssh"
  network = google_compute_network.vpc_network.id

  deny {
    protocol = "tcp"
    ports    = ["22"]
  }

  source_ranges = ["0.0.0.0/0"]
}

resource "google_compute_firewall" "gke_allow_egress" {
  name    = "gke-allow-egress"
  network = google_compute_network.vpc_network.name

  direction = "EGRESS"
  priority  = 1000

  destination_ranges = ["0.0.0.0/0"]

  allow {
    protocol = "all"
  }

  target_tags = ["gke-cluster-node"]
}

resource "google_compute_firewall" "gke_allow_internal" {
  name    = "gke-allow-internal"
  network = google_compute_network.vpc_network.name

  direction = "INGRESS"
  priority  = 1000

  source_ranges = ["10.0.0.0/8"]

  allow {
    protocol = "all"
  }

  target_tags = ["gke-cluster-node"]
}

