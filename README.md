# AWS EKS External DNS Terraform module

[![Labyrinth Labs logo](ll-logo.png)](https://www.lablabs.io)

We help companies build, run, deploy and scale software and infrastructure by embracing the right technologies and principles. Check out our website at https://lablabs.io/

---

![Terraform validation](https://github.com/lablabs/terraform-aws-eks-external-dns/workflows/Terraform%20validation/badge.svg?branch=master)
[![pre-commit](https://img.shields.io/badge/pre--commit-enabled-success?logo=pre-commit&logoColor=white)](https://github.com/pre-commit/pre-commit)

## Description

A terraform module to deploy an ExternalDNS on Amazon EKS cluster.

<!-- BEGINNING OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
## Requirements

| Name | Version |
|------|---------|
| terraform | ~> 0.12.0 |
| aws | ~> 2.0 |
| helm | ~> 1.0 |
| local | ~> 1.2 |
| null | ~> 2.0 |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| cluster\_identity\_oidc\_issuer | n/a | `any` | n/a | yes |
| cluster\_identity\_oidc\_issuer\_arn | n/a | `any` | n/a | yes |
| cluster\_name | n/a | `any` | n/a | yes |
| enabled | n/a | `bool` | n/a | yes |
| helm\_chart\_name | n/a | `string` | `"external-dns"` | no |
| helm\_chart\_version | n/a | `string` | `"3.2.3"` | no |
| helm\_release\_name | n/a | `string` | `"external-dns"` | no |
| helm\_repo\_url | n/a | `string` | `"https://charts.bitnami.com/bitnami"` | no |
| k8s\_namespace | The k8s namespace in which the external-dns service account has been created | `string` | `"kube-system"` | no |
| k8s\_service\_account\_name | The k8s external-dns service account name | `string` | `"external-dns"` | no |
| mod\_dependency | Dependence variable binds all AWS resources allocated by this module, dependent modules reference this variable | `any` | `null` | no |
| policy | Policy for creating or updating records. Possible values: "sync" - allows for full synchronization of DNS records or "upsert-only" - allows everything but deleting DNS records. | `string` | `"upsert-only"` | no |
| policy\_allowed\_zone\_ids | n/a | `list(string)` | <pre>[<br>  "*"<br>]</pre> | no |
| zone\_tags\_filters | n/a | `list(string)` | <pre>[<br>  "external-dns=true"<br>]</pre> | no |

## Outputs

No output.

<!-- END OF PRE-COMMIT-TERRAFORM DOCS HOOK -->

## Contributing and reporting issues

Feel free to create an issue in this repository if you have questions, suggestions or feature requests.

### Validation, linters and pull-requests

We want to provide high quality code and modules. For this reason we are using
several [pre-commit hooks](.pre-commit-config.yaml) and
[GitHub Actions workflow](.github/workflows/main.yml). A pull-request to the
master branch will trigger these validations and lints automatically. Please
check your code before you will create pull-requests. See
[pre-commit documentation](https://pre-commit.com/) and
[GitHub Actions documentation](https://docs.github.com/en/actions) for further
details.


## License

[![License](https://img.shields.io/badge/License-Apache%202.0-blue.svg)](https://opensource.org/licenses/Apache-2.0)

See [LICENSE](LICENSE) for full details.

    Licensed to the Apache Software Foundation (ASF) under one
    or more contributor license agreements.  See the NOTICE file
    distributed with this work for additional information
    regarding copyright ownership.  The ASF licenses this file
    to you under the Apache License, Version 2.0 (the
    "License"); you may not use this file except in compliance
    with the License.  You may obtain a copy of the License at

      https://www.apache.org/licenses/LICENSE-2.0

    Unless required by applicable law or agreed to in writing,
    software distributed under the License is distributed on an
    "AS IS" BASIS, WITHOUT WARRANTIES OR CONDITIONS OF ANY
    KIND, either express or implied.  See the License for the
    specific language governing permissions and limitations
    under the License.
