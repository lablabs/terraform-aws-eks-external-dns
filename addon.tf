# IMPORTANT: This file is synced with the "terraform-aws-eks-universal-addon" module. Any changes to this file might be overwritten upon the next release of that module.
locals {
  addon_argo_source_type         = var.argo_source_type != null ? var.argo_source_type : try(local.addon.argo_source_type, "helm")
  addon_argo_source_helm_enabled = local.addon_argo_source_type == "helm"

  addon_argo_name         = var.argo_name != null ? var.argo_name : try(local.addon.argo_name, local.addon.name)
  addon_helm_release_name = var.helm_release_name != null ? var.helm_release_name : try(local.addon.helm_release_name, local.addon.name)

  addon_name      = local.addon_argo_source_helm_enabled ? local.addon_helm_release_name : local.addon_argo_name
  addon_namespace = var.namespace != null ? var.namespace : try(local.addon.namespace, local.addon.name)
}

module "addon" {
  source = "git::https://github.com/lablabs/terraform-aws-eks-universal-addon.git//modules/addon?ref=v0.0.15"

  enabled = var.enabled

  # variable priority var.* (provided by the module user) > local.addon.* (universal addon default override) > default (universal addon default)
  namespace = local.addon_namespace

  helm_enabled                    = var.helm_enabled != null ? var.helm_enabled : try(local.addon.helm_enabled, true)
  helm_release_name               = local.addon_name
  helm_chart_name                 = var.helm_chart_name != null ? var.helm_chart_name : try(local.addon.helm_chart_name, local.addon.name)
  helm_chart_version              = var.helm_chart_version != null ? var.helm_chart_version : try(local.addon.helm_chart_version, null)
  helm_atomic                     = var.helm_atomic != null ? var.helm_atomic : try(local.addon.helm_atomic, false)
  helm_cleanup_on_fail            = var.helm_cleanup_on_fail != null ? var.helm_cleanup_on_fail : try(local.addon.helm_cleanup_on_fail, false)
  helm_create_namespace           = var.helm_create_namespace != null ? var.helm_create_namespace : try(local.addon.helm_create_namespace, true)
  helm_dependency_update          = var.helm_dependency_update != null ? var.helm_dependency_update : try(local.addon.helm_dependency_update, false)
  helm_description                = var.helm_description != null ? var.helm_description : try(local.addon.helm_description, "")
  helm_devel                      = var.helm_devel != null ? var.helm_devel : try(local.addon.helm_devel, false)
  helm_disable_openapi_validation = var.helm_disable_openapi_validation != null ? var.helm_disable_openapi_validation : try(local.addon.helm_disable_openapi_validation, false)
  helm_disable_webhooks           = var.helm_disable_webhooks != null ? var.helm_disable_webhooks : try(local.addon.helm_disable_webhooks, false)
  helm_force_update               = var.helm_force_update != null ? var.helm_force_update : try(local.addon.helm_force_update, false)
  helm_keyring                    = var.helm_keyring != null ? var.helm_keyring : try(local.addon.helm_keyring, "~/.gnupg/pubring.gpg")
  helm_lint                       = var.helm_lint != null ? var.helm_lint : try(local.addon.helm_lint, false)
  helm_package_verify             = var.helm_package_verify != null ? var.helm_package_verify : try(local.addon.helm_package_verify, false)
  helm_postrender                 = var.helm_postrender != null ? var.helm_postrender : try(local.addon.helm_postrender, {})
  helm_recreate_pods              = var.helm_recreate_pods != null ? var.helm_recreate_pods : try(local.addon.helm_recreate_pods, false)
  helm_release_max_history        = var.helm_release_max_history != null ? var.helm_release_max_history : try(local.addon.helm_release_max_history, 0)
  helm_render_subchart_notes      = var.helm_render_subchart_notes != null ? var.helm_render_subchart_notes : try(local.addon.helm_render_subchart_notes, true)
  helm_replace                    = var.helm_replace != null ? var.helm_replace : try(local.addon.helm_replace, false)
  helm_repo_ca_file               = var.helm_repo_ca_file != null ? var.helm_repo_ca_file : try(local.addon.helm_repo_ca_file, "")
  helm_repo_cert_file             = var.helm_repo_cert_file != null ? var.helm_repo_cert_file : try(local.addon.helm_repo_cert_file, "")
  helm_repo_key_file              = var.helm_repo_key_file != null ? var.helm_repo_key_file : try(local.addon.helm_repo_key_file, "")
  helm_repo_password              = var.helm_repo_password != null ? var.helm_repo_password : try(local.addon.helm_repo_password, "")
  helm_repo_url                   = var.helm_repo_url != null ? var.helm_repo_url : try(local.addon.helm_repo_url, null)
  helm_repo_username              = var.helm_repo_username != null ? var.helm_repo_username : try(local.addon.helm_repo_username, "")
  helm_reset_values               = var.helm_reset_values != null ? var.helm_reset_values : try(local.addon.helm_reset_values, false)
  helm_reuse_values               = var.helm_reuse_values != null ? var.helm_reuse_values : try(local.addon.helm_reuse_values, false)
  helm_set_sensitive              = var.helm_set_sensitive != null ? var.helm_set_sensitive : try(local.addon.helm_set_sensitive, {})
  helm_skip_crds                  = var.helm_skip_crds != null ? var.helm_skip_crds : try(local.addon.helm_skip_crds, false)
  helm_timeout                    = var.helm_timeout != null ? var.helm_timeout : try(local.addon.helm_timeout, 300)
  helm_wait                       = var.helm_wait != null ? var.helm_wait : try(local.addon.helm_wait, false)
  helm_wait_for_jobs              = var.helm_wait_for_jobs != null ? var.helm_wait_for_jobs : try(local.addon.helm_wait_for_jobs, false)

  argo_source_type            = local.addon_argo_source_type
  argo_source_repo_url        = var.argo_source_repo_url != null ? var.argo_source_repo_url : try(local.addon.argo_source_repo_url, null)
  argo_source_target_revision = var.argo_source_target_revision != null ? var.argo_source_target_revision : try(local.addon.argo_source_target_revision, null)
  argo_source_path            = var.argo_source_path != null ? var.argo_source_path : try(local.addon.argo_source_path, null)

  argo_apiversion                                        = var.argo_apiversion != null ? var.argo_apiversion : try(local.addon.argo_apiversion, "argoproj.io/v1alpha1")
  argo_destination_server                                = var.argo_destination_server != null ? var.argo_destination_server : try(local.addon.argo_destination_server, "https://kubernetes.default.svc")
  argo_enabled                                           = var.argo_enabled != null ? var.argo_enabled : try(local.addon.argo_enabled, false)
  argo_helm_enabled                                      = var.argo_helm_enabled != null ? var.argo_helm_enabled : try(local.addon.argo_helm_enabled, false)
  argo_helm_values                                       = var.argo_helm_values != null ? var.argo_helm_values : try(local.addon.argo_helm_values, "")
  argo_helm_wait_backoff_limit                           = var.argo_helm_wait_backoff_limit != null ? var.argo_helm_wait_backoff_limit : try(local.addon.argo_helm_wait_backoff_limit, 6)
  argo_helm_wait_node_selector                           = var.argo_helm_wait_node_selector != null ? var.argo_helm_wait_node_selector : try(local.addon.argo_helm_wait_node_selector, var.argo_helm_wait_node_selector)
  argo_helm_wait_timeout                                 = var.argo_helm_wait_timeout != null ? var.argo_helm_wait_timeout : try(local.addon.argo_helm_wait_timeout, "10m")
  argo_helm_wait_tolerations                             = var.argo_helm_wait_tolerations != null ? var.argo_helm_wait_tolerations : try(local.addon.argo_helm_wait_tolerations, tolist([]))
  argo_helm_wait_kubectl_version                         = var.argo_helm_wait_kubectl_version != null ? var.argo_helm_wait_kubectl_version : try(local.addon.argo_helm_wait_kubectl_version, "1.32.3")
  argo_info                                              = var.argo_info != null ? var.argo_info : try(local.addon.argo_info, [{ name = "terraform", value = "true" }])
  argo_kubernetes_manifest_computed_fields               = var.argo_kubernetes_manifest_computed_fields != null ? var.argo_kubernetes_manifest_computed_fields : try(local.addon.argo_kubernetes_manifest_computed_fields, ["metadata.labels", "metadata.annotations", "metadata.finalizers"])
  argo_kubernetes_manifest_field_manager_force_conflicts = var.argo_kubernetes_manifest_field_manager_force_conflicts != null ? var.argo_kubernetes_manifest_field_manager_force_conflicts : try(local.addon.argo_kubernetes_manifest_field_manager_force_conflicts, false)
  argo_kubernetes_manifest_field_manager_name            = var.argo_kubernetes_manifest_field_manager_name != null ? var.argo_kubernetes_manifest_field_manager_name : try(local.addon.argo_kubernetes_manifest_field_manager_name, "Terraform")
  argo_kubernetes_manifest_wait_fields                   = var.argo_kubernetes_manifest_wait_fields != null ? var.argo_kubernetes_manifest_wait_fields : try(local.addon.argo_kubernetes_manifest_wait_fields, tomap({}))
  argo_metadata                                          = var.argo_metadata != null ? var.argo_metadata : try(local.addon.argo_metadata, { finalizers = ["resources-finalizer.argocd.argoproj.io"] })
  argo_name                                              = local.addon_name
  argo_namespace                                         = var.argo_namespace != null ? var.argo_namespace : try(local.addon.argo_namespace, "argo")
  argo_project                                           = var.argo_project != null ? var.argo_project : try(local.addon.argo_project, "default")
  argo_spec                                              = var.argo_spec != null ? var.argo_spec : try(local.addon.argo_spec, tomap({}))
  argo_sync_policy                                       = var.argo_sync_policy != null ? var.argo_sync_policy : try(local.addon.argo_sync_policy, tomap({}))
  argo_operation                                         = var.argo_operation != null ? var.argo_operation : try(local.addon.argo_operation, tomap({}))

  settings = var.settings != null ? var.settings : try(local.addon.settings, tomap({}))
  values   = one(data.utils_deep_merge_yaml.values[*].output)
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
