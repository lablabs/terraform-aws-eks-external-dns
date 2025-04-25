# IMPORTANT: This file is synced with the "terraform-aws-eks-universal-addon" module. Any changes to this file might be overwritten upon the next release of that module.
module "addon-oidc" {
  for_each = local.addon_oidc

  source = "git::https://github.com/lablabs/terraform-aws-eks-universal-addon.git//modules/addon-oidc?ref=v0.0.14"

  enabled = var.enabled

  oidc_provider_create  = var.oidc_provider_create != null ? var.oidc_provider_create : try(each.value.oidc_provider_create, true)
  oidc_role_create      = var.oidc_role_create != null ? var.oidc_role_create : try(each.value.oidc_role_create, true)
  oidc_role_name_prefix = var.oidc_role_name_prefix != null ? var.oidc_role_name_prefix : try(each.value.oidc_role_name_prefix, "${each.key}-oidc")
  oidc_role_name        = var.oidc_role_name != null ? var.oidc_role_name : try(each.value.oidc_role_name, local.addon_name)

  oidc_policy_enabled                        = var.oidc_policy_enabled != null ? var.oidc_policy_enabled : try(each.value.oidc_policy_enabled, false)
  oidc_policy                                = var.oidc_policy != null ? var.oidc_policy : try(each.value.oidc_policy, "")
  oidc_assume_role_enabled                   = var.oidc_assume_role_enabled != null ? var.oidc_assume_role_enabled : try(each.value.oidc_assume_role_enabled, false)
  oidc_assume_role_arns                      = var.oidc_assume_role_arns != null ? var.oidc_assume_role_arns : try(each.value.oidc_assume_role_arns, [])
  oidc_permissions_boundary                  = var.oidc_permissions_boundary != null ? var.oidc_permissions_boundary : try(each.value.oidc_permissions_boundary, null)
  oidc_additional_policies                   = var.oidc_additional_policies != null ? var.oidc_additional_policies : try(each.value.oidc_additional_policies, tomap({}))
  oidc_openid_client_ids                     = var.oidc_openid_client_ids != null ? var.oidc_openid_client_ids : try(each.value.oidc_openid_client_ids, [])
  oidc_openid_provider_url                   = var.oidc_openid_provider_url != null ? var.oidc_openid_provider_url : try(each.value.oidc_openid_provider_url, "")
  oidc_openid_thumbprints                    = var.oidc_openid_thumbprints != null ? var.oidc_openid_thumbprints : try(each.value.oidc_openid_thumbprints, [])
  oidc_assume_role_policy_condition_variable = var.oidc_assume_role_policy_condition_variable != null ? var.oidc_assume_role_policy_condition_variable : try(each.value.oidc_assume_role_policy_condition_variable, "")
  oidc_assume_role_policy_condition_values   = var.oidc_assume_role_policy_condition_values != null ? var.oidc_assume_role_policy_condition_values : try(each.value.oidc_assume_role_policy_condition_values, [])
  oidc_assume_role_policy_condition_test     = var.oidc_assume_role_policy_condition_test != null ? var.oidc_assume_role_policy_condition_test : try(each.value.oidc_assume_role_policy_condition_test, "StringLike")
  oidc_custom_provider_arn                   = var.oidc_custom_provider_arn != null ? var.oidc_custom_provider_arn : try(each.value.oidc_custom_provider_arn, "")

  oidc_tags = var.oidc_tags != null ? var.oidc_tags : try(each.value.oidc_tags, tomap({}))
}

output "addon_oidc" {
  description = "The addon oidc module outputs"
  value       = module.addon-oidc
}
