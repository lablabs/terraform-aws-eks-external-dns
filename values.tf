locals {
  values = yamlencode({
    "aws" : {
      "region" : data.aws_region.current.name
      "assumeRoleArn" : var.k8s_assume_role_arn
    }
    "rbac" : {
      "create" : var.k8s_rbac_create
    }
    "serviceAccount" : {
      "create" : var.k8s_service_account_create
      "name" : var.k8s_service_account_name
      "annotations" : {
        "eks.amazonaws.com/role-arn" : local.k8s_irsa_role_create ? aws_iam_role.this[0].arn : ""
      }
    }
  })
}

data "aws_region" "current" {}

data "utils_deep_merge_yaml" "values" {
  count = var.enabled ? 1 : 0
  input = compact([
    local.values,
    var.values
  ])
}
