variable "vpc_id" {
  description = "VPC ID where the ECS service will run."
  type        = string
}

variable "subnet_ids" {
  description = "Subnet IDs used by the ECS service."
  type        = set(string)
}
