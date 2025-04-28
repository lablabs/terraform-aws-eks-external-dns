/**
 * # AWS EKS External DNS Terraform module
 *
 * A terraform module to deploy the ExternalDNS on Amazon EKS cluster.
 *
 * [![Terraform validate](https://github.com/lablabs/terraform-aws-eks-universal-addon/actions/workflows/validate.yaml/badge.svg)](https://github.com/lablabs/terraform-aws-eks-universal-addon/actions/workflows/validate.yaml)
 * [![pre-commit](https://github.com/lablabs/terraform-aws-eks-universal-addon/actions/workflows/pre-commit.yaml/badge.svg)](https://github.com/lablabs/terraform-aws-eks-universal-addon/actions/workflows/pre-commit.yaml)
 */

locals {
  addon = {
    name = "external-dns"
    namespace = "kube-system"

    helm_chart_name    = "external-dns"
    helm_chart_version = "6.5.6"
    helm_repo_url      = "https://charts.bitnami.com/bitnami"
  }

  addon_irsa = {
    (local.addon.name) = {
      # This module used role_arn (single) so we use to extend the role_arns (list) for easier usage
      irsa_assume_role_arns_tmp = var.irsa_assume_role_arns != null ? var.irsa_assume_role_arns : []
      irsa_assume_role_arns = var.irsa_assume_role_arn != null ? concat(local.addon.name.irsa_assume_role_arns_tmp, [var.irsa_assume_role_arn]) : local.addon.name.irsa_assume_role_arns_tmp
      irsa_policy = var.irsa_policy != null ? var.irsa_policy : data.aws_iam_policy.this[0].jsons	
    }
  }

  addon_values = yamlencode({
    "aws" : {
      "region" : data.aws_region.current.name
      "assumeRoleArn" : var.irsa_assume_role_arn != null ? var.irsa_assume_role_arn : ""
    }
    "rbac" : {
      "create" : var.rbac_create != null ? var.rbac_create : true
    }
    "serviceAccount" : {
      "create" : var.service_account_create != null ? var.service_account_create : true
      "name" : var.service_account_name != null ? var.service_account_name : local.addon.name
      "annotations" : module.addon-irsa[local.addon.name].irsa_role_enabled ? {
        "eks.amazonaws.com/role-arn" : module.addon-irsa[local.addon.name].iam_role_attributes.arn 
      } : tomap({})
    }
  })
}
