variable "repository_name" {
  description = "Globally unique ECR repository name."
  type        = string
}

variable "repository_display_name" {
  description = "Human-readable repository display name used for the Name tag."
  type        = string
}

variable "encryption_key_arn" {
  description = "KMS key ARN used to encrypt the repository. If null, default ECR encryption (AES256) is used."
  type        = string
  sensitive   = true
  nullable    = true
  default     = null
}

variable "environment" {
  description = "Deployment environment for tagging and validation. Allowed values: development, staging, production."
  type        = string

  validation {
    condition     = contains(["development", "staging", "production"], var.environment)
    error_message = "Environment must be one of the following options: \"development\", \"staging\" or \"production\""
  }
}
