# IMPORTANT: This file is synced with the "terraform-aws-eks-universal-addon" template. Any changes to this file might be overwritten upon the next release of the template.
terraform {
  required_version = ">= 1.8"

  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = ">= 5"
    }
    kubernetes = {
      source  = "hashicorp/kubernetes"
      version = ">= 2.20"
    }
    helm = {
      source  = "hashicorp/helm"
      version = ">= 2.6"
    }
    utils = {
      source  = "cloudposse/utils"
      version = ">= 1"
    }
  }
}
