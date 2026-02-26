variable "vpc_cidr_block" {
  description = "CIDR block for the VPC."
  type        = string
}

variable "vpc_display_name" {
  description = "Human-readable VPC display name used for the Name tag."
  type        = string
}

variable "public_subnets" {
  description = "List of public subnets to create."
  type = list(object({
    cidr_block        = string
    availability_zone = string
  }))

  validation {
    condition     = length(var.public_subnets) >= 1
    error_message = "At least 1 public subnet is required."
  }
}

variable "private_subnets" {
  description = "Optional list of private subnets to create."
  type = list(object({
    cidr_block        = string
    availability_zone = string
  }))
  default = []
}

variable "environment" {
  description = "Deployment environment for tagging and validation. Allowed values: development, staging, production."
  type        = string

  validation {
    condition     = contains(["development", "staging", "production"], var.environment)
    error_message = "Environment must be one of the following options: \"development\", \"staging\" or \"production\""
  }
}
