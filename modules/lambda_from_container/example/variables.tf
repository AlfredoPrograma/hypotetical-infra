variable "function_role_arn" {
  description = "IAM role ARN assumed by the Lambda function."
  type        = string
}

variable "image_uri" {
  description = "Container image URI used by the Lambda function."
  type        = string
}
