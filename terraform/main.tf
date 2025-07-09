terraform {
    # This will tell terraform what plugins it needs to work
    required_providers {
        # To communicate with the cluster
        kubernetes = {
            source  = "hashicorp/kubernetes"
            version = "2.27.0"
        }
        # To install apps needed for the cluster
        helm = {
            source  = "hashicorp/helm"
            version = "2.13.1"
        }
    }
}

# How will terraform connect to the cluster
provider "kubernetes" {
    config_path = "~/.kube/config"
}

# This will tell Terraform to use helm on kubernetes
provider "helm" {
    kubernetes {
        config_path = "~/.kube/config"
    }
}

# This will install Argocd using Helm inside argocd namespace
resource "helm_release" "argocd" {
    name       = "argocd"
    namespace  = "argocd"
    create_namespace = true

    repository = "https://argoproj.github.io/argo-helm"
    chart      = "argo-cd"
    version    = "5.51.6"

    values = [
        file("${path.module}/argocd-values.yaml")
    ]
}

# This will install Prometheus + Grafana using Helm inside monitoring namespace
resource "helm_release" "monitoring" {
    name       = "kps"
    namespace  = "monitoring"
    create_namespace = true

    repository = "https://prometheus-community.github.io/helm-charts"
    chart      = "kube-prometheus-stack"
    version    = "57.0.0"

    values = [
        file("${path.module}/monitoring-values.yaml")
    ]
}