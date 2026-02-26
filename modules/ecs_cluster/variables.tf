variable "cluster_name" {
  description = "ECS cluster name."
  type        = string
}

variable "cluster_display_name" {
  description = "Human-readable cluster display name used for the Name tag."
  type        = string
}

variable "environment" {
  description = "Deployment environment for tagging and validation. Allowed values: development, staging, production."
  type        = string

  validation {
    condition     = contains(["development", "staging", "production"], var.environment)
    error_message = "Environment must be one of the following options: \"development\", \"staging\" or \"production\""
  }
}
