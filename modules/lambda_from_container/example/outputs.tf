output "function_name" {
  description = "Name of the Lambda function."
  value       = module.lambda_from_container.function_name
}

output "function_arn" {
  description = "Amazon Resource Name (ARN) of the Lambda function."
  value       = module.lambda_from_container.function_arn
}

output "invoke_arn" {
  description = "Invoke ARN of the Lambda function."
  value       = module.lambda_from_container.invoke_arn
}
