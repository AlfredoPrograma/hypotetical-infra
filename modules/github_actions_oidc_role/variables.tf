variable "role_name" {
  description = "IAM role name to be assumed by GitHub Actions through OIDC."
  type        = string
}

variable "oidc_provider_arn" {
  description = "ARN of the AWS IAM OIDC provider for GitHub (token.actions.githubusercontent.com)."
  type        = string
}

variable "github_repository" {
  description = "GitHub repository in owner/repo format allowed to assume this role from main branch."
  type        = string
}

variable "environment" {
  description = "Deployment environment tag."
  type        = string
  default     = "development"
}
