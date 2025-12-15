# IMPORTANT: This file is synced with the "terraform-aws-eks-universal-addon" module. Any changes to this file might be overwritten upon the next release of that module.
locals {
  addon_argo_source_type         = var.argo_source_type != null ? var.argo_source_type : try(local.addon.argo_source_type, "helm")
  addon_argo_source_helm_enabled = local.addon_argo_source_type == "helm" || local.addon_argo_source_type == "helm-directory"

  addon_argo_name         = var.argo_name != null ? var.argo_name : try(local.addon.argo_name, local.addon.name)
  addon_helm_release_name = var.helm_release_name != null ? var.helm_release_name : try(local.addon.helm_release_name, local.addon.name)

  addon_name      = local.addon_argo_source_helm_enabled ? local.addon_helm_release_name : local.addon_argo_name
  addon_namespace = var.namespace != null ? var.namespace : try(local.addon.namespace, local.addon.name)
}

module "addon" {
  source = "git::https://github.com/lablabs/terraform-aws-eks-universal-addon.git//modules/addon?ref=feat/data-source-inline"

  enabled = var.enabled

  # variable priority var.* (provided by the module user) > local.addon.* (universal addon default override) > default (universal addon default)
  namespace = local.addon_namespace

  helm_enabled                    = var.helm_enabled != null ? var.helm_enabled : lookup(local.addon, "helm_enabled", null)
  helm_release_name               = local.addon_name
  helm_chart_name                 = var.helm_chart_name != null ? var.helm_chart_name : lookup(local.addon, "helm_chart_name", local.addon.name)
  helm_chart_version              = var.helm_chart_version != null ? var.helm_chart_version : lookup(local.addon, "helm_chart_version", null)
  helm_atomic                     = var.helm_atomic != null ? var.helm_atomic : lookup(local.addon, "helm_atomic", null)
  helm_cleanup_on_fail            = var.helm_cleanup_on_fail != null ? var.helm_cleanup_on_fail : lookup(local.addon, "helm_cleanup_on_fail", null)
  helm_create_namespace           = var.helm_create_namespace != null ? var.helm_create_namespace : lookup(local.addon, "helm_create_namespace", null)
  helm_dependency_update          = var.helm_dependency_update != null ? var.helm_dependency_update : lookup(local.addon, "helm_dependency_update", null)
  helm_description                = var.helm_description != null ? var.helm_description : lookup(local.addon, "helm_description", null)
  helm_devel                      = var.helm_devel != null ? var.helm_devel : lookup(local.addon, "helm_devel", null)
  helm_disable_openapi_validation = var.helm_disable_openapi_validation != null ? var.helm_disable_openapi_validation : lookup(local.addon, "helm_disable_openapi_validation", null)
  helm_disable_webhooks           = var.helm_disable_webhooks != null ? var.helm_disable_webhooks : lookup(local.addon, "helm_disable_webhooks", null)
  helm_force_update               = var.helm_force_update != null ? var.helm_force_update : lookup(local.addon, "helm_force_update", null)
  helm_keyring                    = var.helm_keyring != null ? var.helm_keyring : lookup(local.addon, "helm_keyring", null)
  helm_lint                       = var.helm_lint != null ? var.helm_lint : lookup(local.addon, "helm_lint", null)
  helm_package_verify             = var.helm_package_verify != null ? var.helm_package_verify : lookup(local.addon, "helm_package_verify", null)
  helm_postrender                 = var.helm_postrender != null ? var.helm_postrender : lookup(local.addon, "helm_postrender", null)
  helm_recreate_pods              = var.helm_recreate_pods != null ? var.helm_recreate_pods : lookup(local.addon, "helm_recreate_pods", null)
  helm_release_max_history        = var.helm_release_max_history != null ? var.helm_release_max_history : lookup(local.addon, "helm_release_max_history", null)
  helm_render_subchart_notes      = var.helm_render_subchart_notes != null ? var.helm_render_subchart_notes : lookup(local.addon, "helm_render_subchart_notes", null)
  helm_replace                    = var.helm_replace != null ? var.helm_replace : lookup(local.addon, "helm_replace", null)
  helm_repo_ca_file               = var.helm_repo_ca_file != null ? var.helm_repo_ca_file : lookup(local.addon, "helm_repo_ca_file", null)
  helm_repo_cert_file             = var.helm_repo_cert_file != null ? var.helm_repo_cert_file : lookup(local.addon, "helm_repo_cert_file", null)
  helm_repo_key_file              = var.helm_repo_key_file != null ? var.helm_repo_key_file : lookup(local.addon, "helm_repo_key_file", null)
  helm_repo_password              = var.helm_repo_password != null ? var.helm_repo_password : lookup(local.addon, "helm_repo_password", null)
  helm_repo_url                   = var.helm_repo_url != null ? var.helm_repo_url : lookup(local.addon, "helm_repo_url", null)
  helm_repo_username              = var.helm_repo_username != null ? var.helm_repo_username : lookup(local.addon, "helm_repo_username", null)
  helm_reset_values               = var.helm_reset_values != null ? var.helm_reset_values : lookup(local.addon, "helm_reset_values", null)
  helm_reuse_values               = var.helm_reuse_values != null ? var.helm_reuse_values : lookup(local.addon, "helm_reuse_values", null)
  helm_set_sensitive              = var.helm_set_sensitive != null ? var.helm_set_sensitive : lookup(local.addon, "helm_set_sensitive", null)
  helm_skip_crds                  = var.helm_skip_crds != null ? var.helm_skip_crds : lookup(local.addon, "helm_skip_crds", null)
  helm_timeout                    = var.helm_timeout != null ? var.helm_timeout : lookup(local.addon, "helm_timeout", null)
  helm_wait                       = var.helm_wait != null ? var.helm_wait : lookup(local.addon, "helm_wait", null)
  helm_wait_for_jobs              = var.helm_wait_for_jobs != null ? var.helm_wait_for_jobs : lookup(local.addon, "helm_wait_for_jobs", null)

  argo_source_type            = local.addon_argo_source_type
  argo_source_repo_url        = var.argo_source_repo_url != null ? var.argo_source_repo_url : lookup(local.addon, "argo_source_repo_url", null)
  argo_source_target_revision = var.argo_source_target_revision != null ? var.argo_source_target_revision : lookup(local.addon, "argo_source_target_revision", null)
  argo_source_path            = var.argo_source_path != null ? var.argo_source_path : lookup(local.addon, "argo_source_path", null)

  argo_apiversion                                        = var.argo_apiversion != null ? var.argo_apiversion : lookup(local.addon, "argo_apiversion", null)
  argo_destination_server                                = var.argo_destination_server != null ? var.argo_destination_server : lookup(local.addon, "argo_destination_server", null)
  argo_enabled                                           = var.argo_enabled != null ? var.argo_enabled : lookup(local.addon, "argo_enabled", null)
  argo_helm_enabled                                      = var.argo_helm_enabled != null ? var.argo_helm_enabled : lookup(local.addon, "argo_helm_enabled", null)
  argo_helm_values                                       = var.argo_helm_values != null ? var.argo_helm_values : lookup(local.addon, "argo_helm_values", null)
  argo_helm_wait_backoff_limit                           = var.argo_helm_wait_backoff_limit != null ? var.argo_helm_wait_backoff_limit : lookup(local.addon, "argo_helm_wait_backoff_limit", null)
  argo_helm_wait_node_selector                           = var.argo_helm_wait_node_selector != null ? var.argo_helm_wait_node_selector : lookup(local.addon, "argo_helm_wait_node_selector", null)
  argo_helm_wait_timeout                                 = var.argo_helm_wait_timeout != null ? var.argo_helm_wait_timeout : lookup(local.addon, "argo_helm_wait_timeout", null)
  argo_helm_wait_tolerations                             = var.argo_helm_wait_tolerations != null ? var.argo_helm_wait_tolerations : lookup(local.addon, "argo_helm_wait_tolerations", null)
  argo_helm_wait_kubectl_version                         = var.argo_helm_wait_kubectl_version != null ? var.argo_helm_wait_kubectl_version : lookup(local.addon, "argo_helm_wait_kubectl_version", null)
  argo_info                                              = var.argo_info != null ? var.argo_info : lookup(local.addon, "argo_info", null)
  argo_kubernetes_manifest_computed_fields               = var.argo_kubernetes_manifest_computed_fields != null ? var.argo_kubernetes_manifest_computed_fields : lookup(local.addon, "argo_kubernetes_manifest_computed_fields", null)
  argo_kubernetes_manifest_field_manager_force_conflicts = var.argo_kubernetes_manifest_field_manager_force_conflicts != null ? var.argo_kubernetes_manifest_field_manager_force_conflicts : lookup(local.addon, "argo_kubernetes_manifest_field_manager_force_conflicts", null)
  argo_kubernetes_manifest_field_manager_name            = var.argo_kubernetes_manifest_field_manager_name != null ? var.argo_kubernetes_manifest_field_manager_name : lookup(local.addon, "argo_kubernetes_manifest_field_manager_name", null)
  argo_kubernetes_manifest_wait_fields                   = var.argo_kubernetes_manifest_wait_fields != null ? var.argo_kubernetes_manifest_wait_fields : lookup(local.addon, "argo_kubernetes_manifest_wait_fields", null)
  argo_metadata                                          = var.argo_metadata != null ? var.argo_metadata : lookup(local.addon, "argo_metadata", null)
  argo_name                                              = local.addon_name
  argo_namespace                                         = var.argo_namespace != null ? var.argo_namespace : lookup(local.addon, "argo_namespace", null)
  argo_project                                           = var.argo_project != null ? var.argo_project : lookup(local.addon, "argo_project", null)
  argo_spec                                              = var.argo_spec != null ? var.argo_spec : lookup(local.addon, "argo_spec", null)
  argo_spec_override                                     = var.argo_spec_override != null ? var.argo_spec_override : lookup(local.addon, "argo_spec_override", null)
  argo_sync_policy                                       = var.argo_sync_policy != null ? var.argo_sync_policy : lookup(local.addon, "argo_sync_policy", null)
  argo_operation                                         = var.argo_operation != null ? var.argo_operation : lookup(local.addon, "argo_operation", null)

  settings = var.settings != null ? var.settings : lookup(local.addon, "settings", null)
  values   = one(data.utils_deep_merge_yaml.values[*].output)

  depends_on = [
    local.addon_depends_on,
    var.addon_depends_on
  ]
}

data "utils_deep_merge_yaml" "values" {
  count = var.enabled ? 1 : 0

  input = compact([
    local.addon_values,
    var.values
  ])
}

output "addon" {
  description = "The addon module outputs"
  value       = module.addon
}
