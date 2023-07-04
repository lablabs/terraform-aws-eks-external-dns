output "helm_release_metadata" {
  description = "Helm release attributes"
  value       = try(helm_release.this[0].metadata, {})
}

output "helm_release_application_metadata" {
  description = "Argo application helm release attributes"
  value       = try(helm_release.argo_application[0].metadata, {})
}

output "kubernetes_application_attributes" {
  description = "Argo kubernetes manifest attributes"
  value       = try(kubernetes_manifest.this[0], {})
}

output "iam_role_attributes" {
  description = "External DNS IAM role atributes"
  value       = try(aws_iam_role.this[0], {})
}
