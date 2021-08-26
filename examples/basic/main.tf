module "vpc" {
  source = "terraform-aws-modules/vpc/aws"

  name               = "external-dns-vpc"
  cidr               = "10.0.0.0/16"
  azs                = ["eu-central-1a", "eu-central-1b"]
  public_subnets     = ["10.0.101.0/24", "10.0.102.0/24"]
  enable_nat_gateway = true
}

module "eks_cluster" {
  source = "cloudposse/eks-cluster/aws"

  region     = "eu-central-1"
  subnet_ids = module.vpc.public_subnets
  vpc_id     = module.vpc.vpc_id
  name       = "external-dns"

  workers_security_group_ids = [module.eks_workers.security_group_id]
  workers_role_arns          = [module.eks_workers.workers_role_arn]
}

module "eks_workers" {
  source = "cloudposse/eks-workers/aws"

  cluster_certificate_authority_data = module.eks_cluster.eks_cluster_certificate_authority_data
  cluster_endpoint                   = module.eks_cluster.eks_cluster_endpoint
  cluster_name                       = "external-dns"
  instance_type                      = "t3.medium"
  max_size                           = 1
  min_size                           = 1
  subnet_ids                         = module.vpc.public_subnets
  vpc_id                             = module.vpc.vpc_id

  associate_public_ip_address = true
}

# Use the module:

module "extenral_dns" {
  source = "../../"

  cluster_name                     = module.eks_cluster.eks_cluster_id
  cluster_identity_oidc_issuer     = module.eks_cluster.eks_cluster_identity_oidc_issuer
  cluster_identity_oidc_issuer_arn = module.eks_cluster.eks_cluster_identity_oidc_issuer_arn

  settings = {
    # Examples:

    ## sources:
    ## - service
    ## - ingress

    "sources[0]" = "service"
    "sources[1]" = "ingress"

    ## coredns:
    ##   etcdTLS:
    ##     enabled: false

    "coredns.etcdTLS.enabled" = "false"

    ## extraEnv:
    ## - name: var1
    ##   value: value1
    ## - name: var2
    ##   value: value2

    "extraEnv[0].name"  = "var1"
    "extraEnv[0].value" = "value1"
    "extraEnv[1].name"  = "var2"
    "extraEnv[1].value" = "value2"

    ## extraEnv:
    ## - name: var3
    ##   valueFrom:
    ##     secretKeyRef:
    ##       name: existing-secret
    ##       key: varname3-key

    # "extraEnv[2].name" = "var3"
    # "extraEnv[2].valueFrom.secretKeyRef.name" = "existing-secret"
    # "extraEnv[2].valueFrom.secretKeyRef.key" = "varname3-key"

    # domainFilters:
    #   - foo.com
    #   - bar.com
    "domainFilters[0]" = "foo.com"
    "domainFilters[1]" = "bar.com"

  }

}
