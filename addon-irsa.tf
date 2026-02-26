# IMPORTANT: This file is synced with the "terraform-aws-eks-universal-addon" module. Any changes to this file might be overwritten upon the next release of that module.
module "addon-irsa" {
  for_each = local.addon_irsa

  source = "git::https://github.com/lablabs/terraform-aws-eks-universal-addon.git//modules/addon-irsa?ref=v1.0.0-rc1"

  enabled = var.enabled

  rbac_create               = var.rbac_create != null ? var.rbac_create : lookup(each.value, "rbac_create", null)
  service_account_create    = var.service_account_create != null ? var.service_account_create : lookup(each.value, "service_account_create", null)
  service_account_name      = var.service_account_name != null ? var.service_account_name : lookup(each.value, "service_account_name", local.addon_name)
  service_account_namespace = var.service_account_namespace != null ? var.service_account_namespace : lookup(each.value, "service_account_namespace", local.addon_namespace)

  # IRSA
  cluster_identity_oidc_issuer     = var.cluster_identity_oidc_issuer != null ? var.cluster_identity_oidc_issuer : lookup(each.value, "cluster_identity_oidc_issuer", null)
  cluster_identity_oidc_issuer_arn = var.cluster_identity_oidc_issuer_arn != null ? var.cluster_identity_oidc_issuer_arn : lookup(each.value, "cluster_identity_oidc_issuer_arn", null)

  irsa_role_create      = var.irsa_role_create != null ? var.irsa_role_create : lookup(each.value, "irsa_role_create", null)
  irsa_role_name_prefix = var.irsa_role_name_prefix != null ? var.irsa_role_name_prefix : lookup(each.value, "irsa_role_name_prefix", "${local.addon.name}-irsa")
  irsa_role_name        = var.irsa_role_name != null ? var.irsa_role_name : lookup(each.value, "irsa_role_name", local.addon_name)

  irsa_role_additional_trust_policies = var.irsa_role_additional_trust_policies != null ? var.irsa_role_additional_trust_policies : lookup(each.value, "irsa_role_additional_trust_policies", null)

  irsa_policy_enabled       = var.irsa_policy_enabled != null ? var.irsa_policy_enabled : lookup(each.value, "irsa_policy_enabled", null)
  irsa_policy               = var.irsa_policy != null ? var.irsa_policy : lookup(each.value, "irsa_policy", null)
  irsa_assume_role_enabled  = var.irsa_assume_role_enabled != null ? var.irsa_assume_role_enabled : lookup(each.value, "irsa_assume_role_enabled", null)
  irsa_assume_role_arns     = var.irsa_assume_role_arns != null ? var.irsa_assume_role_arns : lookup(each.value, "irsa_assume_role_arns", null)
  irsa_permissions_boundary = var.irsa_permissions_boundary != null ? var.irsa_permissions_boundary : lookup(each.value, "irsa_permissions_boundary", null)
  irsa_additional_policies  = var.irsa_additional_policies != null ? var.irsa_additional_policies : lookup(each.value, "irsa_additional_policies", null)

  irsa_assume_role_policy_condition_test   = var.irsa_assume_role_policy_condition_test != null ? var.irsa_assume_role_policy_condition_test : lookup(each.value, "irsa_assume_role_policy_condition_test", null)
  irsa_assume_role_policy_condition_values = var.irsa_assume_role_policy_condition_values != null ? var.irsa_assume_role_policy_condition_values : lookup(each.value, "irsa_assume_role_policy_condition_values", null)

  irsa_tags = var.irsa_tags != null ? var.irsa_tags : lookup(each.value, "irsa_tags", null)

  # Pod identity
  cluster_name = var.cluster_name != null ? var.cluster_name : lookup(each.value, "cluster_name", null)

  pod_identity_role_create      = var.pod_identity_role_create != null ? var.pod_identity_role_create : lookup(each.value, "pod_identity_role_create", null)
  pod_identity_role_name_prefix = var.pod_identity_role_name_prefix != null ? var.pod_identity_role_name_prefix : lookup(each.value, "pod_identity_role_name_prefix", "${local.addon.name}-pi")
  pod_identity_role_name        = var.pod_identity_role_name != null ? var.pod_identity_role_name : lookup(each.value, "pod_identity_role_name", local.addon_name)

  pod_identity_role_additional_trust_policies = var.pod_identity_role_additional_trust_policies != null ? var.pod_identity_role_additional_trust_policies : lookup(each.value, "pod_identity_role_additional_trust_policies", null)

  pod_identity_policy_enabled       = var.pod_identity_policy_enabled != null ? var.pod_identity_policy_enabled : lookup(each.value, "pod_identity_policy_enabled", null)
  pod_identity_policy               = var.pod_identity_policy != null ? var.pod_identity_policy : lookup(each.value, "pod_identity_policy", null)
  pod_identity_permissions_boundary = var.pod_identity_permissions_boundary != null ? var.pod_identity_permissions_boundary : lookup(each.value, "pod_identity_permissions_boundary", null)
  pod_identity_additional_policies  = var.pod_identity_additional_policies != null ? var.pod_identity_additional_policies : lookup(each.value, "pod_identity_additional_policies", null)

  pod_identity_tags = var.pod_identity_tags != null ? var.pod_identity_tags : lookup(each.value, "pod_identity_tags", null)
}

output "addon_irsa" {
  description = "The IRSA addon module outputs"
  value       = module.addon-irsa
}
