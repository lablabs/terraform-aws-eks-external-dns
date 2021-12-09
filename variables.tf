variable "enabled" {
  type        = bool
  default     = true
  description = "Variable indicating whether deployment is enabled"
}

variable "cluster_identity_oidc_issuer" {
  type        = string
  description = "The OIDC Identity issuer for the cluster"
}

variable "cluster_identity_oidc_issuer_arn" {
  type        = string
  description = "The OIDC Identity issuer ARN for the cluster that can be used to associate IAM roles with a service account"
}

variable "helm_chart_name" {
  type        = string
  default     = "external-dns"
  description = "Helm chart name to be installed"
}

variable "helm_chart_version" {
  type        = string
  default     = "5.4.4"
  description = "Version of the Helm chart"
}

variable "helm_release_name" {
  type        = string
  default     = "external-dns"
  description = "Helm release name"
}
variable "helm_repo_url" {
  type        = string
  default     = "https://charts.bitnami.com/bitnami"
  description = "Helm repository"
}

variable "helm_create_namespace" {
  type        = bool
  default     = true
  description = "Whether to create k8s namespace with name defined by `k8s_namespace`"
}

variable "k8s_namespace" {
  type        = string
  default     = "kube-system"
  description = "The K8s namespace in which the external-dns will be installed"
}

variable "k8s_rbac_create" {
  type        = bool
  default     = true
  description = "Whether to create and use RBAC resources"
}

variable "k8s_service_account_create" {
  type        = bool
  default     = true
  description = "Whether to create Service Account"
}

variable "k8s_service_account_name" {
  default     = "external-dns"
  description = "The k8s external-dns service account name"
}

variable "k8s_irsa_role_create" {
  type        = bool
  default     = true
  description = "Whether to create IRSA role and annotate service account"
}

variable "k8s_irsa_role_name_prefix" {
  type        = string
  default     = "external-dns-irsa"
  description = "The IRSA role name prefix for prometheus"
}

variable "k8s_assume_role_enabled" {
  type        = bool
  default     = false
  description = "Whether IRSA is allowed to assume role defined by k8s_assume_role_arn. Useful for hosted zones in another AWS account."
}

variable "k8s_assume_role_arn" {
  default     = ""
  description = "Assume role arn. Assume role must be enabled."
}

variable "k8s_irsa_additional_policies" {
  type        = map(string)
  default     = {}
  description = "Map of the additional policies to be attached to default role. Where key is arbiraty id and value is policy arn."
}

variable "k8s_irsa_policy_enabled" {
  type        = bool
  default     = true
  description = "Whether to create opinionated policy to allow operations on specified zones in `policy_allowed_zone_ids`."
}

variable "policy_allowed_zone_ids" {
  type        = list(string)
  default     = ["*"]
  description = "List of the Route53 zone ids for service account IAM role access"
}

variable "settings" {
  type        = map(any)
  default     = {}
  description = "Additional settings which will be passed to the Helm chart values, see https://hub.helm.sh/charts/bitnami/external-dns"
}

variable "values" {
  type        = string
  default     = ""
  description = "Additional yaml encoded values which will be passed to the Helm chart, see https://hub.helm.sh/charts/bitnami/external-dns"
}

variable "argo_namespace" {
  type        = string
  default     = "argo"
  description = "Namespace to deploy ArgoCD application CRD to"
}


variable "argo_application_enabled" {
  type        = bool
  default     = false
  description = "If set to true, the module will be deployed as ArgoCD application, otherwise it will be deployed as a Helm release"
}

variable "argo_application_use_helm" {
  type        = bool
  default     = false
  description = "If set to true, the ArgoCD Application manifest will be deployed using Kubernetes provider as a Helm release. Otherwise it'll be deployed as a Kubernetes manifest. See Readme for more info"
}

variable "argo_application_values" {
  default     = ""
  description = "Value overrides to use when deploying argo application object with helm"
}

variable "argo_destionation_server" {
  type        = string
  default     = "https://kubernetes.default.svc"
  description = "Destination server for ArgoCD Application"
}

variable "argo_project" {
  type        = string
  default     = "default"
  description = "ArgoCD Application project"
}

variable "argo_info" {
  default = [{
    "name"  = "terraform"
    "value" = "true"
  }]
  description = "ArgoCD info manifest parameter"
}

variable "argo_sync_policy" {
  description = "ArgoCD syncPolicy manifest parameter"
  default     = {}
}

variable "tags" {
  type        = map(string)
  default     = {}
  description = "AWS resources tags"
}
