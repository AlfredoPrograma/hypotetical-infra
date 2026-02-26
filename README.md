# (In)fra

This repository contains reusable Terraform modules to provision standardized infrastructure components for different services, including:

- EC2 instances
- Standardized VPC configurations
- Lambda functions for background jobs
- S3 buckets for object storage
- RDS instances for data storage
- ECR repositories for container image storage

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

## `rds_postgres` module

The `modules/rds_postgres` module creates an AWS RDS PostgreSQL instance with standardized defaults for secure networking, encryption, backups, and observability.

Main features:
- PostgreSQL RDS instance provisioning with private networking (`publicly_accessible = false`)
- DB subnet group creation from provided subnets (at least 2 required)
- Database name also used as instance identifier and final snapshot identifier
- Storage encryption enabled with optional custom KMS key
- Deletion protection enabled and final snapshot required on deletion
- Automated backups and PostgreSQL CloudWatch log exports enabled
- Useful outputs such as database endpoint and ARN

## `ecr_repository` module

The `modules/ecr_repository` module creates an AWS ECR repository with standardized defaults for immutable tagging, encryption, and environment tagging.

Main features:
- ECR repository provisioning with immutable image tags (`IMMUTABLE`)
- Encryption configuration with optional custom KMS key
- Standardized tagging using `Name` and `Environment`
- Useful outputs such as repository URL and ARN

## `lambda_from_container` module

The `modules/lambda_from_container` module creates an AWS Lambda function from a container image hosted in a registry such as ECR.

Main features:
- Lambda function provisioning with `package_type = "Image"`
- Configurable function name, execution role ARN, and container image URI
- Useful outputs such as function name, function ARN, and invoke ARN
