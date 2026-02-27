provider "aws" {
  region = "us-east-1"
}

module "github_actions_oidc_role" {
  source = "../"

  role_name         = "sample-web-github-deploy-role"
  oidc_provider_arn = "arn:aws:iam::123456789012:oidc-provider/token.actions.githubusercontent.com"
  github_repository = "my-org/my-repo"
}
