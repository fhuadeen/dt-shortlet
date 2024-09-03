resource "kubernetes_namespace" "namespace" {
  metadata {
    name = var.k8s_namespace
  }
}

resource "kubernetes_config_map" "shortlet_api_config" {
  metadata {
    name      = "shortlet-api-config"
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
        app = "shortlet-api"
      }
    }

    template {
      metadata {
        labels = {
          app = "shortlet-api"
        }
      }

      spec {
        container {
          image = "gcr.io/${var.gcp_project_id}/shortlet-api:latest"
          name  = "shortlet-api"

          port {
            container_port = 8080
          }
        }
      }
    }
  }
}

resource "kubernetes_service" "shortlet_api_service" {
  metadata {
    name      = "shortlet-api-service"
    namespace = kubernetes_namespace.namespace.metadata[0].name
  }

  spec {
    selector = {
      app = "shortlet-api"
    }

    port {
      port        = 80
      target_port = 8080
    }

    type = "LoadBalancer"
  }
}

resource "kubernetes_ingress" "shortlet_api_ingress" {
  metadata {
    name      = var.k8s_ingress_name
    namespace = kubernetes_namespace.namespace.metadata[0].name
  }

  spec {
    backend {
      service_name = kubernetes_service.shortlet_api_service.metadata[0].name
      service_port = 80
    }
  }
}
