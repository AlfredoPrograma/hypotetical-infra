variable "postgres_version" {
  description = "Indicates Postgres engine version."
  type        = string
  default     = "18.2"
}

variable "db_storage_amount" {
  description = "Indicates the storage allocation amount in Gigabytes."
  type        = number
  default     = 80
}

variable "db_instance_class" {
  description = "Indicates AWS instance class for database hosting."
  default     = "db.t3.micro"
}

variable "db_name" {
  description = "Indicates the database name."
  type        = string
}

variable "db_username" {
  description = "Indicates the database username."
  type        = string
}

variable "db_password" {
  description = "Indicates database password."
  type        = string
  sensitive   = true
}

variable "db_display_name" {
  description = "A Human readable name for identifying database."
  type        = string
}

variable "encryption_key_arn" {
  description = "Indicates the KMS key ARN for custom encryption. If null, use default AWS encryption key."
  type        = string
  sensitive   = true
  nullable    = true
  default     = null
}

variable "subnet_ids" {
  description = "Indicates the subnet ids that will be used to host the database."
  type        = set(string)

  validation {
    condition     = length(var.subnet_ids) >= 2
    error_message = "At least 2 subnets are required."
  }
}

variable "vpc_security_groups_ids" {
  description = "Indicates the security group ids that will be applied to the database."
  type        = set(string)
  default     = []
}

variable "environment" {
  description = "Deployment environment for tagging and validation. Allowed values: development, staging, production."
  type        = string

  validation {
    condition     = contains(["development", "staging", "production"], var.environment)
    error_message = "Environment must be one of the following options: \"development\", \"staging\" or \"production\""
  }
}

