# IMPORTANT: This file is synced with the "terraform-aws-eks-universal-addon" module. Any changes to this file might be overwritten upon the next release of that module.

variable "cluster_identity_oidc_issuer" {
  type        = string
  default     = null
  description = "The OIDC Identity issuer for the cluster (required for IRSA). Defaults to `\"\"`."
}

variable "cluster_identity_oidc_issuer_arn" {
  type        = string
  default     = null
  description = "The OIDC Identity issuer ARN for the cluster that can be used to associate IAM roles with a Service Account (required for IRSA). Defaults to `\"\"`."
}

variable "rbac_create" {
  type        = bool
  default     = null
  description = "Whether to create and use RBAC resources. Defaults to `true`."
}

variable "service_account_create" {
  type        = bool
  default     = null
  description = "Whether to create Service Account. Defaults to `true`."
}

variable "service_account_name" {
  type        = string
  default     = null
  description = "The Kubernetes Service Account name. Defaults to the addon name. Defaults to `\"\"`."
}

variable "service_account_namespace" {
  type        = string
  default     = null
  description = "The Kubernetes Service Account namespace. Defaults to the addon namespace. Defaults to `\"\"`."
}

variable "irsa_role_create" {
  type        = bool
  default     = null
  description = "Whether to create IRSA role and annotate Service Account. Defaults to `true`."
}

variable "irsa_role_name_prefix" {
  type        = string
  default     = null
  description = "IRSA role name prefix. Either `irsa_role_name_prefix` or `irsa_role_name` must be set. Defaults to `\"\"`."
}

variable "irsa_role_name" {
  type        = string
  default     = null
  description = "IRSA role name. The value is prefixed by `irsa_role_name_prefix`. Either `irsa_role_name` or `irsa_role_name_prefix` must be set. Defaults to `\"\"`."
}

variable "irsa_policy_enabled" {
  type        = bool
  default     = null
  description = "Whether to create IAM policy specified by `irsa_policy`. Mutually exclusive with `irsa_assume_role_enabled`. Defaults to `false`."
}

variable "irsa_policy" {
  type        = string
  default     = null
  description = "AWS IAM policy JSON document to be attached to the IRSA role. Applied only if `irsa_policy_enabled` is `true`. Defaults to `\"\"`."
}

variable "irsa_assume_role_enabled" {
  type        = bool
  default     = null
  description = "Whether IRSA is allowed to assume role defined by `irsa_assume_role_arn`. Mutually exclusive with `irsa_policy_enabled`. Defaults to `false`."
}

variable "irsa_assume_role_arns" {
  type        = list(string)
  default     = null
  description = "List of ARNs assumable by the IRSA role. Applied only if `irsa_assume_role_enabled` is `true`. Defaults to `[]`."
}

variable "irsa_permissions_boundary" {
  type        = string
  default     = null
  description = "ARN of the policy that is used to set the permissions boundary for the IRSA role. Defaults to `null`."
}

variable "irsa_additional_policies" {
  type        = map(string)
  default     = null
  description = "Map of the additional policies to be attached to IRSA role. Where key is arbitrary id and value is policy ARN. Defaults to `{}`."
}

variable "irsa_tags" {
  type        = map(string)
  default     = null
  description = "IRSA resources tags. Defaults to `{}`."
}

variable "irsa_assume_role_policy_condition_test" {
  type        = string
  default     = null
  description = "Specifies the condition test to use for the assume role trust policy. Defaults to `StringEquals`."
}

variable "irsa_assume_role_policy_condition_values" {
  type        = list(string)
  default     = null
  description = "Specifies the values for the assume role trust policy condition. Each entry in this list must follow the required format `system:serviceaccount:$service_account_namespace:$service_account_name`. If this variable is left as the default, `local.irsa_assume_role_policy_condition_values_default` is used instead, which is a list containing a single value. Note that if this list is defined, the `service_account_name` and `service_account_namespace` variables are ignored. Defaults to `[]`."
}

variable "cluster_name" {
  type        = string
  default     = null
  description = "The name of the cluster (required for pod identity). Defaults to `\"\"`."
}

variable "pod_identity_role_create" {
  type        = bool
  default     = null
  description = "Whether to create pod identity role and annotate Service Account. Defaults to `false`."
}

variable "pod_identity_role_name_prefix" {
  type        = string
  default     = null
  description = "Pod identity role name prefix. Either `pod_identity_role_name_prefix` or `pod_identity_role_name` must be set. Defaults to `\"\"`."
}

variable "pod_identity_role_name" {
  type        = string
  default     = null
  description = "Pod identity role name. The value is prefixed by `pod_identity_role_name_prefix`. Either `pod_identity_role_name` or `pod_identity_role_name_prefix` must be set. Defaults to `\"\"`."
}

variable "pod_identity_policy_enabled" {
  type        = bool
  default     = null
  description = "Whether to create IAM policy specified by `pod_identity_policy`. Defaults to `false`."
}

variable "pod_identity_policy" {
  type        = string
  default     = null
  description = "AWS IAM policy JSON document to be attached to the pod identity role. Applied only if `pod_identity_policy_enabled` is `true`. Defaults to `\"\"`."
}

variable "pod_identity_permissions_boundary" {
  type        = string
  default     = null
  description = "ARN of the policy that is used to set the permissions boundary for the pod identity role. Defaults to `null`."
}

variable "pod_identity_additional_policies" {
  type        = map(string)
  default     = null
  description = "Map of the additional policies to be attached to pod identity role. Where key is arbitrary id and value is policy ARN. Defaults to `{}`."
}

variable "pod_identity_tags" {
  type        = map(string)
  default     = null
  description = "Pod identity resources tags. Defaults to `{}`."
}
