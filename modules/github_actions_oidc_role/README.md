# github_actions_oidc_role module

Terraform module to create a minimal AWS IAM role for GitHub Actions OIDC deployments.

This module is intentionally simple and opinionated:
- Only allows `main` branch from one repository (`owner/repo`).
- Attaches AWS managed `PowerUserAccess` and adds a narrow inline IAM policy for Terraform ECS role operations (`CreateRole`, role policy attach/inline policy updates, and constrained `PassRole`).

## Usage

```hcl
provider "aws" {
  region = "us-east-1"
}

module "github_actions_oidc_role" {
  source = "../"

  role_name         = "sample-web-github-deploy-role"
  oidc_provider_arn = "arn:aws:iam::123456789012:oidc-provider/token.actions.githubusercontent.com"
  github_repository = "my-org/my-repo"
}
```

## Inputs

| Name | Type | Required | Default | Description |
|---|---|---|---|---|
| `role_name` | `string` | Yes | `-` | IAM role name to be assumed by GitHub Actions through OIDC. |
| `oidc_provider_arn` | `string` | Yes | `-` | ARN of the AWS IAM OIDC provider for GitHub (`token.actions.githubusercontent.com`). |
| `github_repository` | `string` | Yes | `-` | GitHub repository in `owner/repo` format allowed to assume this role from `main` branch. |
| `environment` | `string` | No | `"development"` | Deployment environment tag. |

## Outputs

| Name | Type | Description |
|---|---|---|
| `role_name` | `string` | Name of the IAM role for GitHub Actions OIDC. |
| `role_arn` | `string` | Amazon Resource Name (ARN) of the IAM role for GitHub Actions OIDC. |
| `assume_role_policy` | `string` | Rendered IAM trust policy JSON used by the role. |
