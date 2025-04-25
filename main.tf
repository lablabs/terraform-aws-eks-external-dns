/**
 * # AWS EKS Universal Addon Terraform module
 *
 * A Terraform module to deploy the universal addon on Amazon EKS cluster.
 *
 * [![Terraform validate](https://github.com/lablabs/terraform-aws-eks-universal-addon/actions/workflows/validate.yaml/badge.svg)](https://github.com/lablabs/terraform-aws-eks-universal-addon/actions/workflows/validate.yaml)
 * [![pre-commit](https://github.com/lablabs/terraform-aws-eks-universal-addon/actions/workflows/pre-commit.yaml/badge.svg)](https://github.com/lablabs/terraform-aws-eks-universal-addon/actions/workflows/pre-commit.yaml)
 */
# FIXME config: update addon docs above
locals {
  # FIXME config: add addon configuration here
  addon = {
    name = "universal-addon"

    helm_chart_name    = "raw"
    helm_chart_version = "0.1.0"
    helm_repo_url      = "https://lablabs.github.io"
  }

  # FIXME config: add addon IRSA configuration here or remove if not needed
  addon_irsa = {
    (local.addon.name) = {
      # FIXME config: add default IRSA overrides here or leave empty if not needed, but make sure to keep at least one key
    }
  }

  # FIXME config: add addon OIDC configuration here or remove if not needed
  addon_oidc = {
    (local.addon.name) = {
      # FIXME config: add default OIDC overrides here or leave empty if not needed, but make sure to keep at least one key
    }
  }

  addon_values = yamlencode({
    # FIXME config: add default values here
  })
}
