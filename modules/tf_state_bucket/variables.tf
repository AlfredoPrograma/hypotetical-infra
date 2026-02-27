variable "bucket_name" {
  description = "Globally unique S3 bucket name used to store Terraform state files."
  type        = string
}

variable "bucket_display_name" {
  description = "Human-readable bucket display name used for the Name tag."
  type        = string
}

variable "environment" {
  description = "Environment tag value attached to resources."
  type        = string
  default     = "common"
}

variable "force_destroy" {
  description = "Whether to allow bucket deletion even when it contains objects. Keep false for safety in production."
  type        = bool
  default     = false
}

variable "enable_lifecycle_configuration" {
  description = "Whether to create lifecycle configuration for noncurrent object versions."
  type        = bool
  default     = true
}

variable "noncurrent_version_expiration_days" {
  description = "Days to retain noncurrent object versions in the state bucket."
  type        = number
  default     = 30
}
