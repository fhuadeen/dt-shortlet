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

variable "shortlet_deploy_replica_count" {
  description = "Number of replicas for shortlet app deployment"
  type        = number
}

variable "service_account_token" {
  description = "Service account access token"
  type        = string
}

variable "k8s_namespace" {
  description = "Kubernetes Namespace"
  type        = string
}

variable "k8s_shortlet_deployment_name" {
  description = "Shortlet API Deployment name on Kubernetes"
  type        = string
}

variable "k8s_ingress_name" {
  description = "Kubernetes Ingress name"
  type        = string
}

variable "k8s_node_label" {
  description = "Kubernetes node label"
  type = string
}
