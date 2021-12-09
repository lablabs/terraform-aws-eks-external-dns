terraform {
  required_version = ">= 0.14"

  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = ">= 2.0"
    }
    kubernetes = {
      source  = "hashicorp/kubernetes"
      version = ">= 2.6"
    }
    helm = {
      source  = "hashicorp/helm"
      version = ">= 1.0.0"
    }
    utils = {
      source  = "cloudposse/utils"
      version = ">= 0.14.0"
    }
  }
}
