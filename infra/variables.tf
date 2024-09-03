variable "gcp_project_id" {
  description = "GCP project ID"
  type        = string
}

variable "gcp_region" {
  description = "GCP region"
  type        = string
}

variable "gcp_zone" {
  description = "GCP zone"
  type        = string
}

variable "k8s_cluster_name" {
  description = "Kubernetes cluster name"
  type        = string
}

variable "init_node_count" {
  description = "Initial node count"
  type        = number
}

# variable "gcp_sa_key" {
#   description = "GCP service account key"
#   type = object({
#     type                        = string
#     project_id                  = string
#     private_key_id              = string
#     private_key                 = string
#     client_email                = string
#     client_id                   = string
#     auth_uri                    = string
#     token_uri                   = string
#     auth_provider_x509_cert_url = string
#     client_x509_cert_url        = string
#     universe_domain             = string
#   })
# }

variable "shortlet_deploy_replica_count" {
  description = "Number of replicas for shortlet app deployment"
  type        = number
}

variable "service_account_token" {
  description = "Service account access token"
  type        = string
}
