output "cluster_name" {
  value = google_container_cluster.primary.name
}

output "api_service_ip" {
  value = kubernetes_service.shortlet_api_service.status[0].load_balancer[0].ingress[0].ip
}
