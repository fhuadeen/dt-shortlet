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