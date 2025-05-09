/**
 * # AWS EKS External DNS Terraform module
 *
 * A terraform module to deploy the [ExternalDNS](https://kubernetes-sigs.github.io/external-dns/latest) on Amazon EKS cluster.
 *
 * [![Terraform validate](https://github.com/lablabs/terraform-aws-eks-external-dns/actions/workflows/validate.yaml/badge.svg)](https://github.com/lablabs/terraform-aws-eks-external-dns/actions/workflows/validate.yaml)
 * [![pre-commit](https://github.com/lablabs/terraform-aws-eks-external-dns/workflows/pre-commit.yml/badge.svg)](https://github.com/lablabs/terraform-aws-eks-external-dns/actions/workflows/pre-commit.yml)
 *
 */

locals {
  addon = {
    name      = "external-dns"
    namespace = "kube-system"

    helm_chart_version = "1.15.1"
    helm_repo_url      = "https://kubernetes-sigs.github.io/external-dns"

  }

  addon_irsa = {
    (local.addon.name) = {
      irsa_policy_enabled = local.irsa_policy_enabled
      irsa_policy         = var.irsa_policy != null ? var.irsa_policy : try(data.aws_iam_policy_document.this[0].json, "")
    }
  }

  addon_values = yamlencode({
    provider = {
      name = "aws"
    }
    rbac = {
      create = var.rbac_create != null ? var.rbac_create : true
    }
    serviceAccount = {
      create = var.service_account_create != null ? var.service_account_create : true
      name   = var.service_account_name != null ? var.service_account_name : local.addon.name
      annotations = module.addon-irsa[local.addon.name].irsa_role_enabled ? {
        "eks.amazonaws.com/role-arn" = module.addon-irsa[local.addon.name].iam_role_attributes.arn
      } : tomap({})
    }
    extraArgs = one(var.irsa_assume_role_arns[*]) != null ? ["--aws-assume-role=${one(var.irsa_assume_role_arns[*])}"] : []
  })
}
