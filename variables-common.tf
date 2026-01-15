# IMPORTANT: This file is synced with the "terraform-aws-eks-universal-addon" template. Any changes to this file might be overwritten upon the next release of the template.

variable "enabled" {
  type        = bool
  default     = true
  description = "Set to false to prevent the module from creating any resources."
  nullable    = false
}

variable "addon_depends_on" {
  type        = list(any)
  default     = []
  description = "List of resources to wait for before installing the addon. Typically used to force a dependency on another addon."
  nullable    = false
}
