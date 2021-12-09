module "example" {
  source = "../../"

  cluster_identity_oidc_issuer     = module.eks_cluster.eks_cluster_identity_oidc_issuer
  cluster_identity_oidc_issuer_arn = module.eks_cluster.eks_cluster_identity_oidc_issuer_arn

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
  })
}

module "example-assume" {
  source = "../../"

  cluster_identity_oidc_issuer     = module.eks_cluster.eks_cluster_identity_oidc_issuer
  cluster_identity_oidc_issuer_arn = module.eks_cluster.eks_cluster_identity_oidc_issuer_arn

  k8s_assume_role_enabled = true
  k8s_assume_role_arn     = "arn"
  values = yamlencode({
    "LogLevel" : "debug"
    "provider" : "aws"
    "registry" : "txt"
    "txtOwnerId" : "eks-cluster"
    "txtPrefix" : "external-dns"
    "policy" : "sync"
    "zoneType" : "public"
    "extraArgs" : {
      "annotation-filter=external-dns.alpha.kubernetes.io/class=example" : ""
    }
    "domainFilters" : [
      "example.com"
    ]
    "publishInternalServices" : "true"
    "triggerLoopOnEvent" : "true"
    "interval" : "5s"
  })

}

module "disabled" {
  source = "../../"

  enabled = false

  cluster_identity_oidc_issuer     = module.eks_cluster.eks_cluster_identity_oidc_issuer
  cluster_identity_oidc_issuer_arn = module.eks_cluster.eks_cluster_identity_oidc_issuer_arn
}
