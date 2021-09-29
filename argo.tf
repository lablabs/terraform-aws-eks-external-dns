resource "kubernetes_manifest" "this" {
  count = var.argo_application_enabled ? 1 : 0
  manifest = {
    "apiVersion" = "argoproj.io/v1alpha1"
    "kind"       = "Application"
    "metadata" = {
      "name"      = var.helm_release_name
      "namespace" = var.argo_namespace
    }
    "spec" = {
      "project" = var.argo_project
      "source" = {
        "repoURL"        = var.helm_repo_url
        "chart"          = var.helm_chart_name
        "targetRevision" = var.helm_chart_version
        "helm" = {
          "releaseName" = var.helm_release_name
          "parameters"  = [for k, v in var.settings : tomap({ "forceString" : true, "name" : k, "value" : v })]
          "values"      = data.utils_deep_merge_yaml.values[0].output
        }
      }
      "destination" = {
        "server"    = var.argo_destionation_server
        "namespace" = var.k8s_namespace
      }
      "syncPolicy" = var.argo_sync_policy
      "info"       = var.argo_info
    }
  }
}
