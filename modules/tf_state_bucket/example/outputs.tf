output "bucket_name" {
  description = "Name of the Terraform state S3 bucket."
  value       = module.tf_state_bucket.bucket_name
}

output "bucket_arn" {
  description = "Amazon Resource Name (ARN) of the Terraform state bucket."
  value       = module.tf_state_bucket.bucket_arn
}
