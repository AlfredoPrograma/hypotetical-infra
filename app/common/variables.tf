variable "aws_region" {
  description = "AWS region where common resources are deployed."
  type        = string
  default     = "us-east-1"
}

variable "tf_state_bucket_name" {
  description = "Globally unique S3 bucket name used for Terraform remote state."
  type        = string
}

variable "tf_state_bucket_display_name" {
  description = "Human-readable Name tag for Terraform state bucket."
  type        = string
  default     = "Terraform State Bucket"
}

variable "tf_state_bucket_force_destroy" {
  description = "Whether state bucket can be destroyed with objects. Keep false for safety."
  type        = bool
  default     = false
}

variable "tf_state_enable_lifecycle_configuration" {
  description = "Whether to expire noncurrent state object versions."
  type        = bool
  default     = true
}

variable "tf_state_noncurrent_version_expiration_days" {
  description = "Retention window in days for noncurrent state object versions."
  type        = number
  default     = 30
}

variable "github_actions_role_name" {
  description = "IAM role name for GitHub Actions OIDC deployments."
  type        = string
}

variable "github_oidc_provider_arn" {
  description = "ARN of the AWS IAM OIDC provider for GitHub (token.actions.githubusercontent.com)."
  type        = string
}

variable "github_repository" {
  description = "GitHub repository in owner/repo format allowed to assume the role from main branch."
  type        = string
}
