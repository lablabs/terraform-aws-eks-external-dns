locals {
  rbac_create            = var.rbac_create != null ? var.rbac_create : true
  service_account_create = var.service_account_create != null ? var.service_account_create : true
  irsa_role_create       = var.irsa_role_create != null ? var.irsa_role_create : true
  irsa_policy_enabled    = var.enabled && local.rbac_create && local.service_account_create && local.irsa_role_create == false
}

data "aws_iam_policy_document" "this" {
  count = var.enabled && var.irsa_policy == null && local.irsa_policy_enabled ? 1 : 0

  statement {
    sid    = "ChangeResourceRecordSets"
    effect = "Allow"
    actions = [
      "route53:ChangeResourceRecordSets",
    ]
    resources = formatlist(
      "arn:%s:route53:::hostedzone/%s",
      var.aws_partition,
      var.policy_allowed_zone_ids
    )
  }

  statement {
    sid    = "ListResourceRecordSets"
    effect = "Allow"
    actions = [
      "route53:ListHostedZones",
      "route53:ListResourceRecordSets",
      "route53:ListTagsForResource",
    ]
    resources = [
      "*",
    ]
  }
}
