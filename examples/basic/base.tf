module "vpc" {
  source  = "terraform-aws-modules/vpc/aws"
  version = "4.0.0"

  name               = "external-dns-vpc"
  cidr               = "10.0.0.0/16"
  azs                = ["eu-central-1a", "eu-central-1b"]
  public_subnets     = ["10.0.101.0/24", "10.0.102.0/24"]
  enable_nat_gateway = true
}

module "eks_cluster" {
  source  = "cloudposse/eks-cluster/aws"
  version = "2.3.0"

  region     = "eu-central-1"
  subnet_ids = module.vpc.public_subnets
  vpc_id     = module.vpc.vpc_id
  name       = "basic-example"
}

module "eks_node_group" {
  source  = "cloudposse/eks-node-group/aws"
  version = "2.4.0"

  cluster_name   = module.eks_cluster.eks_cluster_id
  instance_types = ["t3.medium"]
  subnet_ids     = module.vpc.public_subnets
  min_size       = 1
  desired_size   = 1
  max_size       = 2
  depends_on     = [module.eks_cluster.kubernetes_config_map_id]
}
