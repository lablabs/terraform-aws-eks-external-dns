provider "helm" {
  alias = "real"

  kubernetes = {
    host     = "https://127.0.0.1:65535"
    token    = "test"
    insecure = true
  }
}

run "helm_release_v3_checks" {
  command = plan

  providers = {
    helm = helm.real
  }

  module {
    source = "./modules/addon"
  }

  variables {
    enabled           = true
    helm_enabled      = true
    argo_enabled      = false
    argo_helm_enabled = false

    namespace          = "test"
    helm_chart_name    = "hello-world"
    helm_chart_version = "0.1.0"
    helm_release_name  = "test-helm-release"
    helm_repo_url      = "https://helm.github.io/examples"
    values             = ""
  }

  assert {
    condition     = helm_release.this[0].description == null
    error_message = "When helm_description is not set, addon module should set helm_release description to null, not empty string."
  }
  assert {
    condition     = helm_release.this[0].keyring == null
    error_message = "When helm_package_verify is false, addon module should set helm_release keyring to null regardless of helm_keyring input."
  }
}
