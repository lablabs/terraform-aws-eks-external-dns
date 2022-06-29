module "external_dns_disabled" {
  source = "../../"

  enabled = false

  cluster_identity_oidc_issuer     = module.eks_cluster.eks_cluster_identity_oidc_issuer
  cluster_identity_oidc_issuer_arn = module.eks_cluster.eks_cluster_identity_oidc_issuer_arn
}

module "external_dns_without_irsa_role" {
  source = "../../"

  irsa_role_create                 = false
  cluster_identity_oidc_issuer     = module.eks_cluster.eks_cluster_identity_oidc_issuer
  cluster_identity_oidc_issuer_arn = module.eks_cluster.eks_cluster_identity_oidc_issuer_arn
}

module "external_dns_without_irsa_policy" {
  source = "../../"

  enabled = false

  irsa_policy_enabled              = false
  cluster_identity_oidc_issuer     = module.eks_cluster.eks_cluster_identity_oidc_issuer
  cluster_identity_oidc_issuer_arn = module.eks_cluster.eks_cluster_identity_oidc_issuer_arn
}

module "external_dns_assume" {
  source = "../../"

  cluster_identity_oidc_issuer     = module.eks_cluster.eks_cluster_identity_oidc_issuer
  cluster_identity_oidc_issuer_arn = module.eks_cluster.eks_cluster_identity_oidc_issuer_arn

  irsa_assume_role_enabled = true
  irsa_assume_role_arn     = "arn"
}

module "external_dns_helm" {
  source = "../../"

  enabled           = true
  argo_enabled      = false
  argo_helm_enabled = false

  cluster_identity_oidc_issuer     = module.eks_cluster.eks_cluster_identity_oidc_issuer
  cluster_identity_oidc_issuer_arn = module.eks_cluster.eks_cluster_identity_oidc_issuer_arn

  helm_release_name = "aws-ext-dns-helm"
  namespace         = "aws-external-dns-helm"

  values = yamlencode({
    "LogLevel" : "debug"
    "provider" : "aws"
    "registry" : "txt"
    "txtOwnerId" : "eks-cluster"
    "txtPrefix" : "external-dns"
    "policy" : "sync"
    "domainFilters" : [
      "example.com"
    ]
    "publishInternalServices" : "true"
    "triggerLoopOnEvent" : "true"
    "interval" : "5s"
    "podLabels" : {
      "app" : "aws-external-dns-helm"
    }
  })

  helm_timeout = 240
  helm_wait    = true
}

module "external_dns_argo_kubernetes" {
  source = "../../"

  enabled           = true
  argo_enabled      = true
  argo_helm_enabled = false

  cluster_identity_oidc_issuer     = module.eks_cluster.eks_cluster_identity_oidc_issuer
  cluster_identity_oidc_issuer_arn = module.eks_cluster.eks_cluster_identity_oidc_issuer_arn

  helm_release_name = "aws-ext-dns-argo-kubernetes"
  namespace         = "aws-external-dns-argo-kubernetes"

  argo_sync_policy = {
    "automated" : {}
    "syncOptions" = ["CreateNamespace=true"]
  }
}

module "external_dns_argo_helm" {
  source = "../../"

  enabled           = true
  argo_enabled      = true
  argo_helm_enabled = true

  cluster_identity_oidc_issuer     = module.eks_cluster.eks_cluster_identity_oidc_issuer
  cluster_identity_oidc_issuer_arn = module.eks_cluster.eks_cluster_identity_oidc_issuer_arn

  helm_release_name = "aws-ext-dns-argo-helm"
  namespace         = "aws-external-dns-argo-helm"

  argo_namespace = "argo"
  argo_sync_policy = {
    "automated" : {}
    "syncOptions" = ["CreateNamespace=true"]
  }
}
