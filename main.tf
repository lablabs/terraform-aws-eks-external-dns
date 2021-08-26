locals {
  values = yamlencode({
    "aws" : {
      "region" : data.aws_region.current.name
    }
    "rbac" : {
      "create" : true
    }
    "serviceAccount" : {
      "create" : true
      "name" : var.k8s_service_account_name
      "annotations" : {
        "eks.amazonaws.com/role-arn" : aws_iam_role.external_dns[0].arn
      }
    }
  })
}

data "utils_deep_merge_yaml" "values" {
  count = var.enabled ? 1 : 0
  input = compact([
    local.values,
    var.values
  ])
}

data "aws_region" "current" {}

resource "helm_release" "external_dns" {
  count            = var.enabled ? 1 : 0
  chart            = var.helm_chart_name
  create_namespace = var.k8s_create_namespace
  namespace        = var.k8s_namespace
  name             = var.helm_release_name
  version          = var.helm_chart_version
  repository       = var.helm_repo_url

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
}
