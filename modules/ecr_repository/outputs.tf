output "repository_url" {
  description = "ECR repository URL used to push and pull container images."
  value       = aws_ecr_repository.this.repository_url
}

output "repository_arn" {
  description = "Amazon Resource Name (ARN) of the ECR repository."
  value       = aws_ecr_repository.this.arn
}
