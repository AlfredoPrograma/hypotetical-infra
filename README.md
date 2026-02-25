# (In)fra

This repository contains reusable Terraform modules to provision standardized infrastructure components for different services, including:

- EC2 instances
- Standardized VPC configurations
- Lambda functions for background jobs
- S3 buckets for object storage
- RDS instances for data storage

The goal is to provide a consistent, repeatable way to create infrastructure aligned with the hypothetical **(In)fra** company standards.

## `s3_bucket` module

The `modules/s3_bucket` module creates an AWS S3 bucket with baseline configuration for secure and predictable usage across environments.

Main features:
- Bucket creation with standardized tagging (`Name` and `Environment`)
- Bucket versioning enabled
- Server-side encryption enabled by default (SSE-S3 with `AES256`)
- Optional public access block configuration
- Optional CORS configuration through input rules
- Useful outputs such as bucket ARN and bucket domain name
