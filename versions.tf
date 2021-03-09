terraform {
  required_version = ">= 0.13"

  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = ">= 2.0"
    }
    helm = {
      source  = "hashicorp/helm"
      version = ">= 1.0"
    }
    null = {
      source  = "hashicorp/null"
      version = ">= 2.0"
    }
    local = {
      source  = "hashicorp/local"
      version = ">= 1.3"
    }
    kubernetes = {
      source  = "hashicorp/kubernetes"
      version = ">= 1.10"
    }
  }
}
