output "repository_url" {
  description = "ECR repository URL used to push and pull container images."
  value       = module.ecr_repository.repository_url
}

output "repository_arn" {
  description = "Amazon Resource Name (ARN) of the ECR repository."
  value       = module.ecr_repository.repository_arn
}
