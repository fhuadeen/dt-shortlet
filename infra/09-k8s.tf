resource "kubernetes_namespace" "namespace" {
  metadata {
    name = var.k8s_namespace
  }
}

resource "kubernetes_config_map" "shortlet_api_config" {
  metadata {
    name      = "shortlet-app-config"
    namespace = kubernetes_namespace.namespace.metadata[0].name
  }

}

resource "kubernetes_deployment" "shortlet_api_deployment" {
  metadata {
    name      = var.k8s_shortlet_deployment_name
    namespace = kubernetes_namespace.namespace.metadata[0].name
  }

  spec {
    replicas = var.shortlet_deploy_replica_count

    selector {
      match_labels = {
        app = "shortlet-app"
      }
    }

    template {
      metadata {
        labels = {
          app = "shortlet-app"
        }
      }

      spec {
        node_selector = {
          role = var.k8s_node_label
        }

        container {
          # image = "gcr.io/${var.gcp_project_id}/shortlet-app:latest"
          image = "fhuadeen/shortlet-app:latest"
          name  = "shortlet-app"

          resources {
            limits = {
              cpu    = "0.5"
              memory = "512Mi"
            }
            requests = {
              cpu    = "250m"
              memory = "128Mi"
            }
          }

          port {
            container_port = 8000
          }
        }
      }
    }
  }
}

resource "kubernetes_service" "shortlet_api_service" {
  metadata {
    name      = "shortlet-app-service"
    namespace = kubernetes_namespace.namespace.metadata[0].name
  }

  spec {
    selector = {
      app = "shortlet-app"
    }

    port {
      port        = 8000
      target_port = 8000
    }

    type = "LoadBalancer"
  }
}

resource "kubernetes_ingress_v1" "shortlet_api_ingress" {
  metadata {
    name      = var.k8s_ingress_name
    namespace = kubernetes_namespace.namespace.metadata[0].name
  }

  spec {
    rule {
      http {
        path {
          path = "/"
          path_type = "Prefix"
          backend {
            service {
              name = kubernetes_service.shortlet_api_service.metadata[0].name
              port {
                number = 8000
              }
            }
          }
        }
      }
    }
  }
}
