# IMPORTANT: Add addon specific variables here
variable "enabled" {
  type        = bool
  default     = true
  description = "Set to false to prevent the module from creating any resources."
}

variable "irsa_assume_role_arn" {
  type        = string
  default     = ""
  description = "Assume role arn. Assume role must be enabled."
}

variable "policy_allowed_zone_ids" {
  type        = list(string)
  default     = ["*"]
  description = "List of the Route53 zone ids for service account IAM role access"
}

variable "aws_partition" {
  type        = string
  default     = "aws"
  description = "AWS partition in which the resources are located. Avaliable values are `aws`, `aws-cn`, `aws-us-gov`"
}
