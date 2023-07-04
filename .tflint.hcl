plugin "terraform" {
  enabled = true
  version = "0.1.1"
  source  = "github.com/terraform-linters/tflint-ruleset-terraform"
  preset  = "recommended"
}
plugin "aws" {
  enabled = true
  version = "0.17.0"
  source  = "github.com/terraform-linters/tflint-ruleset-aws"
}
