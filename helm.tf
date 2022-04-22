resource "helm_release" "this" {
  count            = var.enabled && !var.argo_enabled ? 1 : 0
  chart            = var.helm_chart_name
  create_namespace = var.helm_create_namespace
  namespace        = var.namespace
  name             = var.helm_release_name
  version          = var.helm_chart_version
  repository       = var.helm_repo_url

  repository_key_file        = var.helm_repo_key_file
  repository_cert_file       = var.helm_repo_cert_file
  repository_ca_file         = var.helm_repo_ca_file
  repository_username        = var.helm_repo_username
  repository_password        = var.helm_repo_password
  devel                      = var.helm_devel
  verify                     = var.helm_package_verify
  keyring                    = var.helm_keyring
  timeout                    = var.helm_timeout
  disable_webhooks           = var.helm_disable_webhooks
  reset_values               = var.helm_reset_values
  reuse_values               = var.helm_reuse_values
  force_update               = var.helm_force_update
  recreate_pods              = var.helm_recreate_pods
  cleanup_on_fail            = var.helm_cleanup_on_fail
  max_history                = var.helm_release_max_history
  atomic                     = var.helm_atomic
  wait                       = var.helm_wait
  wait_for_jobs              = var.helm_wait_for_jobs
  skip_crds                  = var.helm_skip_crds
  render_subchart_notes      = var.helm_render_subchart_notes
  disable_openapi_validation = var.helm_disable_openapi_validation
  dependency_update          = var.helm_dependency_update
  replace                    = var.helm_replace
  description                = var.helm_description
  lint                       = var.helm_lint

  values = [
    data.utils_deep_merge_yaml.values[0].output
  ]

  dynamic "set" {
    for_each = var.settings
    content {
      name  = set.key
      value = set.value
    }
  }

  dynamic "set_sensitive" {
    for_each = var.helm_set_sensitive
    content {
      name  = set_sensitive.key
      value = set_sensitive.value
    }
  }

  dynamic "postrender" {
    for_each = var.helm_postrender
    content {
      binary_path = postrender.value
    }
  }

}
