provider "aws" {
  region = "eu-central-1"
}

data "aws_eks_cluster" "this" {
  name = module.eks_cluster.eks_cluster_id
}

data "aws_eks_cluster_auth" "this" {
  name = module.eks_cluster.eks_cluster_id
}

provider "kubernetes" {
  host                   = data.aws_eks_cluster.this.endpoint
  cluster_ca_certificate = base64decode(data.aws_eks_cluster.this.certificate_authority.0.data)
  token                  = data.aws_eks_cluster_auth.this.token
}

provider "helm" {
  kubernetes {
    host                   = data.aws_eks_cluster.this.endpoint
    token                  = data.aws_eks_cluster_auth.this.token
    cluster_ca_certificate = base64decode(data.aws_eks_cluster.this.certificate_authority.0.data)
  }
}
