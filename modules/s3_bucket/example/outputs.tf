output "bucket_url" {
  description = "S3 bucket domain name."
  value       = module.s3_bucket.bucket_url
}

output "bucket_arn" {
  description = "Amazon Resource Name (ARN) of the S3 bucket."
  value       = module.s3_bucket.bucket_arn
}
