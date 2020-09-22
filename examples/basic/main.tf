module "vpc" {
  source = "terraform-aws-modules/vpc/aws"

  name               = "cluster-autoscaler-vpc"
  cidr               = "10.0.0.0/16"
  azs                = ["eu-central-1a", "eu-central-1b"]
  public_subnets     = ["10.0.101.0/24", "10.0.102.0/24"]
  enable_nat_gateway = true
}

module "eks_cluster" {
  source  = "cloudposse/eks-cluster/aws"
  version = "0.28.0"

  region     = "eu-central-1"
  subnet_ids = module.vpc.public_subnets
  vpc_id     = module.vpc.vpc_id
  name       = "cluster-autoscaler"

  workers_security_group_ids = [module.eks_workers.security_group_id]
  workers_role_arns          = [module.eks_workers.workers_role_arn]
}

module "eks_workers" {
  source  = "cloudposse/eks-workers/aws"
  version = "0.15.2"

  cluster_certificate_authority_data = module.eks_cluster.eks_cluster_certificate_authority_data
  cluster_endpoint                   = module.eks_cluster.eks_cluster_endpoint
  cluster_name                       = module.eks_cluster.eks_cluster_id
  cluster_security_group_id          = module.eks_cluster.security_group_id
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
}
