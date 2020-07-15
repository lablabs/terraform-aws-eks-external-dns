# Required module inputs

variable "cluster_name" {}
variable "cluster_identity_oidc_issuer" {}
variable "cluster_identity_oidc_issuer_arn" {}

variable "policy_allowed_zone_ids" {
  type    = list(string)
  default = ["*"]
}

# external-dns

variable "enabled" {
  type = bool
}

variable "zone_tags_filters" {
  type    = list(string)
  default = ["external-dns=true"]
}

variable "policy" {
  default     = "upsert-only"
  description = "Policy for creating or updating records. Possible values: \"sync\" - allows for full synchronization of DNS records or \"upsert-only\" - allows everything but deleting DNS records."
}

# Helm

variable "helm_chart_name" {
  default = "external-dns"
}

variable "helm_chart_version" {
  default = "3.2.3"
}

variable "helm_release_name" {
  default = "external-dns"
}

variable "helm_repo_url" {
  default = "https://charts.bitnami.com/bitnami"
}

# K8S

variable "k8s_namespace" {
  default     = "kube-system"
  description = "The k8s namespace in which the external-dns service account has been created"
}

variable "k8s_service_account_name" {
  default     = "external-dns"
  description = "The k8s external-dns service account name"
}

variable "mod_dependency" {
  default     = null
  description = "Dependence variable binds all AWS resources allocated by this module, dependent modules reference this variable"
}
