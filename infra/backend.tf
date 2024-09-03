terraform {
  backend "gcs" {
    bucket = "shoplet-tf-state"
    prefix = "terraform/state"
    # impersonate_service_account = ""
    credentials = "../shortlet-sa.json"
    # access_token = ""
  }
}