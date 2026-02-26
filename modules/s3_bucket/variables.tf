variable "bucket_name" {
  description = "Globally unique S3 bucket name. Must satisfy AWS S3 bucket naming rules."
  type        = string
}

variable "bucket_display_name" {
  description = "Human-readable bucket display name used for the Name tag."
  type        = string
}

variable "bucket_cors_configuration" {
  description = "List of CORS rules to apply to the bucket. If empty, no CORS configuration is created."
  type = list(object({
    headers         = list(string)
    methods         = list(string)
    origins         = list(string)
    expiration_time = number
  }))
}

variable "block_public_access" {
  description = "Whether to create an S3 Public Access Block configuration for this bucket."
  type        = bool
  default     = false
}

variable "encryption_key_arn" {
  description = "KMS key ARN intended for SSE-KMS encryption. Currently unused by this module; encryption is configured as SSE-S3 (AES256)."
  type        = string
  nullable    = true
  sensitive   = true
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
