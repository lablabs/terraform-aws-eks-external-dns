module "vpc" {
  source  = "terraform-aws-modules/vpc/aws"
  version = "5.21.0"

  name                    = "vpc"
  cidr                    = "10.0.0.0/16"
  azs                     = ["eu-central-1a", "eu-central-1b"]
  private_subnets         = ["10.0.1.0/24", "10.0.2.0/24"]
  public_subnets          = ["10.0.101.0/24", "10.0.102.0/24"]
  enable_nat_gateway      = true
  map_public_ip_on_launch = true
}

module "eks_cluster" {
  source  = "cloudposse/eks-cluster/aws"
  version = "4.6.0"

  kubernetes_version    = "1.31"
  oidc_provider_enabled = true

  access_entry_map = {
    (data.aws_iam_session_context.current.issuer_arn) = {
      access_policy_associations = {
        ClusterAdmin = {}
      }
    }
  }

  name       = "eks"
  region     = data.aws_region.this.name
  subnet_ids = module.vpc.public_subnets
}

module "eks_node_group" {
  source  = "cloudposse/eks-node-group/aws"
  version = "3.3.0"

  cluster_name   = module.eks_cluster.eks_cluster_id
  instance_types = ["t3.medium"]
  subnet_ids     = module.vpc.public_subnets
  min_size       = 1
  desired_size   = 1
  max_size       = 2
  depends_on     = [module.eks_cluster.kubernetes_config_map_id]
}
