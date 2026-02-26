variable "aws_region" {
  description = "AWS region where resources are deployed."
  type        = string
  default     = "us-east-1"
}

variable "vpc_display_name" {
  description = "Human-readable VPC display name."
  type        = string
  default     = "Hypotetical VPC"
}

variable "vpc_cidr_block" {
  description = "CIDR block for the VPC."
  type        = string
  default     = "172.30.0.0/16"
}

variable "public_subnets" {
  description = "Public subnets for the VPC."
  type = list(object({
    availability_zone = string
    cidr_block        = string
  }))
  default = [
    {
      availability_zone = "us-east-1a"
      cidr_block        = "172.30.0.0/20"
    },
    {
      availability_zone = "us-east-1b"
      cidr_block        = "172.30.16.0/20"
    }
  ]
}

variable "private_subnets" {
  description = "Private subnets for the VPC."
  type = list(object({
    availability_zone = string
    cidr_block        = string
  }))
  default = [
    {
      availability_zone = "us-east-1a"
      cidr_block        = "172.30.32.0/20"
    }
  ]
}

variable "repository_display_name" {
  description = "Human-readable ECR repository display name."
  type        = string
  default     = "Hypotetical ECR Repository"
}

variable "repository_name" {
  description = "ECR repository name."
  type        = string
  default     = "hypotetical-ecr-repository"
}

variable "cluster_display_name" {
  description = "Human-readable ECS cluster display name."
  type        = string
  default     = "Hypotetical ECS Cluster"
}

variable "cluster_name" {
  description = "ECS cluster name."
  type        = string
  default     = "hypotetical-ecs"
}

variable "nginx_service_name" {
  description = "ECS service name for nginx."
  type        = string
  default     = "nginx"
}

variable "nginx_container_name" {
  description = "Container name for nginx task definition."
  type        = string
  default     = "nginx"
}

variable "nginx_container_image" {
  description = "Container image URI used by nginx service."
  type        = string
  default     = "884891704616.dkr.ecr.us-east-1.amazonaws.com/hypotetical-ecr-repository:0.0.1"
}

variable "nginx_container_port" {
  description = "Port exposed by nginx container."
  type        = number
  default     = 80
}

variable "nginx_assign_public_ip" {
  description = "Whether ECS tasks should receive a public IP."
  type        = bool
  default     = true
}

variable "nginx_ingress_cidr_blocks" {
  description = "Allowed CIDR blocks to reach nginx service."
  type        = list(string)
  default     = ["0.0.0.0/0"]
}

variable "nginx_s3_actions" {
  description = "S3 actions granted to the nginx ECS task role."
  type        = list(string)
  default = [
    "s3:GetObject",
    "s3:PutObject",
    "s3:DeleteObject",
    "s3:ListBucket",
  ]
}

variable "bucket_name" {
  description = "S3 bucket name."
  type        = string
  default     = "hypotetical-s3-bucket"
}

variable "bucket_display_name" {
  description = "Human-readable S3 bucket display name."
  type        = string
  default     = "Hypotetical S3 Bucket"
}

variable "bucket_cors_configuration" {
  description = "CORS rules for S3 bucket."
  type = list(object({
    expiration_time = number
    headers         = list(string)
    methods         = list(string)
    origins         = list(string)
  }))
  default = [
    {
      expiration_time = 3000
      headers         = ["*"]
      methods         = ["GET", "PUT"]
      origins         = ["http://localhost:3000"]
    }
  ]
}

variable "s3_block_public_access" {
  description = "Whether to block public access on the S3 bucket."
  type        = bool
  default     = true
}
