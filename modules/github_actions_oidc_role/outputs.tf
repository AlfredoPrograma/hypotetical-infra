output "role_name" {
  description = "Name of the IAM role for GitHub Actions OIDC."
  value       = aws_iam_role.this.name
}

output "role_arn" {
  description = "Amazon Resource Name (ARN) of the IAM role for GitHub Actions OIDC."
  value       = aws_iam_role.this.arn
}

output "assume_role_policy" {
  description = "Rendered IAM trust policy JSON used by the role."
  value       = data.aws_iam_policy_document.assume_role.json
}
