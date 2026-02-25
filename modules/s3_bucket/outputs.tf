output "bucket_url" {
  description = "S3 bucket domain name."
  value       = aws_s3_bucket.this.bucket_domain_name
}

output "bucket_arn" {
  description = "Amazon Resource Name (ARN) of the S3 bucket."
  value       = aws_s3_bucket.this.arn
}
