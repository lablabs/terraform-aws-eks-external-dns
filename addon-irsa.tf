# IMPORTANT: This file is synced with the "terraform-aws-eks-universal-addon" module. Any changes to this file might be overwritten upon the next release of that module.
module "addon-irsa" {
  for_each = local.addon_irsa

  source = "git::https://github.com/lablabs/terraform-aws-eks-universal-addon.git//modules/addon-irsa?ref=v0.0.15"

  enabled = var.enabled

  rbac_create               = var.rbac_create != null ? var.rbac_create : try(each.value.rbac_create, true)
  service_account_create    = var.service_account_create != null ? var.service_account_create : try(each.value.service_account_create, true)
  service_account_name      = var.service_account_name != null ? var.service_account_name : try(each.value.service_account_name, each.key)
  service_account_namespace = var.service_account_namespace != null ? var.service_account_namespace : try(each.value.service_account_namespace, local.addon_namespace)

  # IRSA
  cluster_identity_oidc_issuer     = var.cluster_identity_oidc_issuer != null ? var.cluster_identity_oidc_issuer : try(each.value.cluster_identity_oidc_issuer, "")
  cluster_identity_oidc_issuer_arn = var.cluster_identity_oidc_issuer_arn != null ? var.cluster_identity_oidc_issuer_arn : try(each.value.cluster_identity_oidc_issuer_arn, "")

  irsa_role_create      = var.irsa_role_create != null ? var.irsa_role_create : try(each.value.irsa_role_create, true)
  irsa_role_name_prefix = var.irsa_role_name_prefix != null ? var.irsa_role_name_prefix : try(each.value.irsa_role_name_prefix, "${each.key}-irsa")
  irsa_role_name        = var.irsa_role_name != null ? var.irsa_role_name : try(each.value.irsa_role_name, local.addon_name)

  irsa_policy_enabled       = var.irsa_policy_enabled != null ? var.irsa_policy_enabled : try(each.value.irsa_policy_enabled, false)
  irsa_policy               = var.irsa_policy != null ? var.irsa_policy : try(each.value.irsa_policy, "")
  irsa_assume_role_enabled  = var.irsa_assume_role_enabled != null ? var.irsa_assume_role_enabled : try(each.value.irsa_assume_role_enabled, false)
  irsa_assume_role_arns     = var.irsa_assume_role_arns != null ? var.irsa_assume_role_arns : try(each.value.irsa_assume_role_arns, [])
  irsa_permissions_boundary = var.irsa_permissions_boundary != null ? var.irsa_permissions_boundary : try(each.value.irsa_permissions_boundary, null)
  irsa_additional_policies  = var.irsa_additional_policies != null ? var.irsa_additional_policies : lookup(each.value, "irsa_additional_policies", tomap({}))

  irsa_assume_role_policy_condition_test   = var.irsa_assume_role_policy_condition_test != null ? var.irsa_assume_role_policy_condition_test : try(each.value.irsa_assume_role_policy_condition_test, "StringEquals")
  irsa_assume_role_policy_condition_values = var.irsa_assume_role_policy_condition_values != null ? var.irsa_assume_role_policy_condition_values : try(each.value.irsa_assume_role_policy_condition_values, [])

  irsa_tags = var.irsa_tags != null ? var.irsa_tags : try(each.value.irsa_tags, tomap({}))

  # Pod identity
  cluster_name = var.cluster_name != null ? var.cluster_name : try(each.value.cluster_name, "")

  pod_identity_role_create      = var.pod_identity_role_create != null ? var.pod_identity_role_create : try(each.value.pod_identity_role_create, false)
  pod_identity_role_name_prefix = var.pod_identity_role_name_prefix != null ? var.pod_identity_role_name_prefix : try(each.value.pod_identity_role_name_prefix, "${each.key}-pi")
  pod_identity_role_name        = var.pod_identity_role_name != null ? var.pod_identity_role_name : try(each.value.pod_identity_role_name, local.addon_name)

  pod_identity_policy_enabled       = var.pod_identity_policy_enabled != null ? var.pod_identity_policy_enabled : try(each.value.pod_identity_policy_enabled, false)
  pod_identity_policy               = var.pod_identity_policy != null ? var.pod_identity_policy : try(each.value.pod_identity_policy, "")
  pod_identity_permissions_boundary = var.pod_identity_permissions_boundary != null ? var.pod_identity_permissions_boundary : try(each.value.pod_identity_permissions_boundary, null)
  pod_identity_additional_policies  = var.pod_identity_additional_policies != null ? var.pod_identity_additional_policies : lookup(each.value, "pod_identity_additional_policies", tomap({}))

  pod_identity_tags = var.pod_identity_tags != null ? var.pod_identity_tags : try(each.value.pod_identity_tags, tomap({}))
}

output "addon_irsa" {
  description = "The addon IRSA module outputs"
  value       = module.addon-irsa
}
