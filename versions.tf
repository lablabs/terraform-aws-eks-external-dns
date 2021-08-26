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
    utils = {
      source  = "cloudposse/utils"
      version = ">= 0.12.0"
    }
  }
}
