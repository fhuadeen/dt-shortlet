# iam.tf

resource "google_project_iam_member" "gke_admin" {
  project = var.gcp_project_id
  role    = "roles/container.admin"
  member  = "serviceAccount:${google_service_account.gke_sa.email}"
}

resource "google_service_account" "gke_sa" {
  account_id   = "gke-sa"
  display_name = "Shorlet GKE Service Account"
}
