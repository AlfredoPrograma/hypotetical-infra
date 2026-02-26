variable "cluster_name" {
  description = "Name of the parent ECS cluster where the service will run."
  type        = string
}

variable "service_name" {
  description = "ECS service name."
  type        = string
}

variable "container_name" {
  description = "Container name used in the task definition."
  type        = string
}

variable "container_image" {
  description = "Container image URI for the service."
  type        = string
}

variable "container_port" {
  description = "Exposed TCP port for the container."
  type        = number
  default     = 80
}

variable "task_cpu" {
  description = "CPU units for the Fargate task definition."
  type        = number
  default     = 256
}

variable "task_memory" {
  description = "Memory (MiB) for the Fargate task definition."
  type        = number
  default     = 512
}

variable "desired_count" {
  description = "Initial desired number of running tasks."
  type        = number
  default     = 1
}

variable "min_capacity" {
  description = "Minimum number of tasks for autoscaling."
  type        = number
  default     = 1
}

variable "max_capacity" {
  description = "Maximum number of tasks for autoscaling."
  type        = number
  default     = 3
}

variable "cpu_target_value" {
  description = "Target average CPU utilization percentage for autoscaling."
  type        = number
  default     = 70
}

variable "memory_target_value" {
  description = "Target average memory utilization percentage for autoscaling."
  type        = number
  default     = 75
}

variable "aws_region" {
  description = "AWS region used by container log configuration."
  type        = string
}

variable "vpc_id" {
  description = "VPC ID where the ECS service security group is created."
  type        = string
}

variable "subnet_ids" {
  description = "Subnet IDs used by the ECS service network configuration."
  type        = set(string)

  validation {
    condition     = length(var.subnet_ids) >= 1
    error_message = "At least 1 subnet ID is required."
  }
}

variable "ingress_cidr_blocks" {
  description = "CIDR blocks allowed to access the container port."
  type        = list(string)
  default     = ["0.0.0.0/0"]
}

variable "assign_public_ip" {
  description = "Whether to assign a public IP to tasks."
  type        = bool
  default     = true
}

variable "log_retention_in_days" {
  description = "CloudWatch log retention period in days."
  type        = number
  default     = 7
}

variable "environment" {
  description = "Deployment environment for tagging and validation. Allowed values: development, staging, production."
  type        = string

  validation {
    condition     = contains(["development", "staging", "production"], var.environment)
    error_message = "Environment must be one of the following options: \"development\", \"staging\" or \"production\""
  }
}
