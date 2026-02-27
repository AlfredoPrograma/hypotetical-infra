output "tf_state_bucket" {
  description = "Terraform state bucket outputs."
  value = {
    bucket_name        = module.tf_state_bucket.bucket_name
    bucket_arn         = module.tf_state_bucket.bucket_arn
    bucket_domain_name = module.tf_state_bucket.bucket_domain_name
    region             = var.aws_region
  }
}

output "github_actions_oidc_role" {
  description = "GitHub Actions OIDC role outputs."
  value = {
    role_name = module.github_actions_oidc_role.role_name
    role_arn  = module.github_actions_oidc_role.role_arn
  }
}
