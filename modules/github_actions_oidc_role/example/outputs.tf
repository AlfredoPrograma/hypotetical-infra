output "role_arn" {
  description = "IAM role ARN for GitHub Actions role-to-assume."
  value       = module.github_actions_oidc_role.role_arn
}
