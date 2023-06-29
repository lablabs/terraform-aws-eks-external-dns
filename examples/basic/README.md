# Basic example

The code in this example shows how to use the module with basic configuration and minimal set of other resources.

<!-- BEGINNING OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | >= 1.0 |
| <a name="requirement_aws"></a> [aws](#requirement\_aws) | >= 4.19.0 |
| <a name="requirement_helm"></a> [helm](#requirement\_helm) | >= 2.6.0 |
| <a name="requirement_kubernetes"></a> [kubernetes](#requirement\_kubernetes) | >= 2.11.0 |

## Modules

| Name | Source | Version |
|------|--------|---------|
| <a name="module_eks_cluster"></a> [eks\_cluster](#module\_eks\_cluster) | cloudposse/eks-cluster/aws | 2.3.0 |
| <a name="module_eks_node_group"></a> [eks\_node\_group](#module\_eks\_node\_group) | cloudposse/eks-node-group/aws | 2.4.0 |
| <a name="module_external_dns_argo_helm"></a> [external\_dns\_argo\_helm](#module\_external\_dns\_argo\_helm) | ../../ | n/a |
| <a name="module_external_dns_argo_kubernetes"></a> [external\_dns\_argo\_kubernetes](#module\_external\_dns\_argo\_kubernetes) | ../../ | n/a |
| <a name="module_external_dns_assume"></a> [external\_dns\_assume](#module\_external\_dns\_assume) | ../../ | n/a |
| <a name="module_external_dns_disabled"></a> [external\_dns\_disabled](#module\_external\_dns\_disabled) | ../../ | n/a |
| <a name="module_external_dns_helm"></a> [external\_dns\_helm](#module\_external\_dns\_helm) | ../../ | n/a |
| <a name="module_external_dns_without_irsa_policy"></a> [external\_dns\_without\_irsa\_policy](#module\_external\_dns\_without\_irsa\_policy) | ../../ | n/a |
| <a name="module_external_dns_without_irsa_role"></a> [external\_dns\_without\_irsa\_role](#module\_external\_dns\_without\_irsa\_role) | ../../ | n/a |
| <a name="module_vpc"></a> [vpc](#module\_vpc) | terraform-aws-modules/vpc/aws | 4.0.0 |

## Resources

| Name | Type |
|------|------|
| [aws_eks_cluster.this](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/eks_cluster) | data source |
| [aws_eks_cluster_auth.this](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/eks_cluster_auth) | data source |

## Inputs

No inputs.

## Outputs

No outputs.
<!-- END OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
