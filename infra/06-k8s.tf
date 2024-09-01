resource "kubernetes_namespace" "namespace" {
  metadata {
    name = "shortlet-namespace"
  }
}

resource "kubernetes_config_map" "api_config" {
  metadata {
    name      = "api-config"
    namespace = kubernetes_namespace.namespace.metadata[0].name
  }

  data = {
    api-key = "your-api-key"
  }
}

resource "kubernetes_deployment" "api_deployment" {
  metadata {
    name      = "api-deployment"
    namespace = kubernetes_namespace.namespace.metadata[0].name
  }

  spec {
    replicas = 3

    selector {
      match_labels = {
        app = "my-api"
      }
    }

    template {
      metadata {
        labels = {
          app = "my-api"
        }
      }

      spec {
        container {
          image = "gcr.io/${var.gcp_project_id}/my-api:v1"
          name  = "my-api"

          env {
            name  = "API_KEY"
            value_from {
              config_map_key_ref {
                name = kubernetes_config_map.api_config.metadata[0].name
                key  = "api-key"
              }
            }
          }

          ports {
            container_port = 8080
          }
        }
      }
    }
  }
}

resource "kubernetes_service" "api_service" {
  metadata {
    name      = "api-service"
    namespace = kubernetes_namespace.namespace.metadata[0].name
  }

  spec {
    selector = {
      app = "my-api"
    }

    ports {
      port        = 80
      target_port = 8080
    }

    type = "LoadBalancer"
  }
}

resource "kubernetes_ingress" "api_ingress" {
  metadata {
    name      = "api-ingress"
    namespace = kubernetes_namespace.namespace.metadata[0].name
  }

  spec {
    backend {
      service_name = kubernetes_service.api_service.metadata[0].name
      service_port = 80
    }
  }
}
