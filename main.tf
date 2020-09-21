data "aws_region" "current" {}

resource "helm_release" "external_dns" {
  depends_on = [var.mod_dependency]
  count      = var.enabled ? 1 : 0
  chart      = var.helm_chart_name
  namespace  = var.k8s_namespace
  name       = var.helm_release_name
  version    = var.helm_chart_version
  repository = var.helm_repo_url

  set {
    name  = "aws.region"
    value = data.aws_region.current.name
  }

  set {
    name  = "rbac.create"
    value = "true"
  }

  set {
    name  = "serviceAccount.create"
    value = "true"
  }

  set {
    name  = "serviceAccount.name"
    value = var.k8s_service_account_name
  }

  set {
    name  = "serviceAccount.annotations.eks\\.amazonaws\\.com/role-arn"
    value = aws_iam_role.external_dns[0].arn
  }

  dynamic "set" {
    for_each = var.settings
    content {
      name  = set.key
      value = set.value
    }
  }
}

#
#  values = [
#    "${templatefile("${path.module}/templates/values.yaml.tpl",
#      {
#        "cluster_name"              = var.cluster_name,
#        "zone_tags_filters"         = var.zone_tags_filters
#        "policy"                    = var.policy
#        "external_dns_iam_role_arn" = aws_iam_role.external_dns[0].arn
#        "service_account_name"      = var.k8s_service_account_name
#        "aws_region"                = data.aws_region.current.name
#      })
#    }"
#  ]
#
