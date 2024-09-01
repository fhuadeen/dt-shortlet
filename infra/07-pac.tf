resource "google_organization_policy" "restrict_ports" {
  constraint = "compute.googleapis.com/restrictLoadBalancerPorts"

  boolean_policy {
    enforced = true
  }

  policy {
    bindings {
      role = "roles/editor"

      members = [
        "serviceAccount:${google_service_account.gke_sa.email}",
      ]
    }
  }
}
