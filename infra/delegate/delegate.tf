terraform {
  required_providers {
    kubernetes = {
      source  = "hashicorp/kubernetes"
      version = "~> 2.0"
    }
    helm = {
      source  = "hashicorp/helm"
      version = ">= 2.0"
    }
  }
}

# Provider config for EKS - using existing ~/.kube/config
provider "kubernetes" {
  config_path = "~/.kube/config"
}

provider "helm" {
  kubernetes {
    config_path = "~/.kube/config"
  }
}

resource "kubernetes_namespace" "harness_delegate" {
  metadata {
    name = "harness-delegate-ng"
  }
}


module "delegate" {
  source  = "harness/harness-delegate/kubernetes"
  version = "0.2.2"

  account_id       = "ucHySz2jQKKWQweZdXyCog"
  delegate_token   = "NTRhYTY0Mjg3NThkNjBiNjMzNzhjOGQyNjEwOTQyZjY="
  delegate_name    = "vm-eks-delegate"
  deploy_mode      = "KUBERNETES"
  namespace        = kubernetes_namespace.harness_delegate.metadata[0].name
  manager_endpoint = "https://app.harness.io"
  delegate_image   = "us-docker.pkg.dev/gar-prod-setup/harness-public/harness/delegate:25.05.85903"
  replicas         = 1
  upgrader_enabled = true

  depends_on = [kubernetes_namespace.harness_delegate]
}
