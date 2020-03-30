# Required module inputs
variable "cluster_name" {}
variable "cluster_identity_oidc_issuer" {}
variable "cluster_identity_oidc_issuer_arn" {}

# external-dns
variable "enabled" {
  type = bool
}

variable "zone_tags_filters" {
  type    = list
  default = ["external-dns=true"]
}

# Helm
variable "helm_chart_name" {
  default = "external-dns"
}

variable "helm_chart_version" {
  default = "2.11.0"
}

variable "helm_release_name" {
  default = "external-dns"
}

variable "helm_repo_name" {
  default = "stable"
}

variable "helm_repo_url" {
  default = "https://kubernetes-charts.storage.googleapis.com"
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
  default = null
}