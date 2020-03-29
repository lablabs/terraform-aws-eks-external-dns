resource "kubernetes_namespace" "external_dns" {
  depends_on  = [var.mod_dependency] 
  count = (var.enabled && var.k8s_namespace != "kube-system") ? 1 : 0

  metadata {
    name = var.k8s_namespace
  }
}
