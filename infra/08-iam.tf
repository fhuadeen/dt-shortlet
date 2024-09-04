resource "google_project_service" "iam_api" {
  service                    = "iam.googleapis.com"
  disable_on_destroy         = false
  disable_dependent_services = true

  lifecycle {
    prevent_destroy = true
  }
}

resource "google_project_iam_member" "gke_admin" {
  project = var.gcp_project_id
  role    = "roles/container.admin"
  member  = "serviceAccount:${google_service_account.gke_sa.email}"

  depends_on = [google_project_service.iam_api]
}

resource "google_service_account" "gke_sa" {
  account_id   = "gke-sa"
  display_name = "Shorlet GKE Service Account"

  depends_on = [google_project_service.iam_api]
}
