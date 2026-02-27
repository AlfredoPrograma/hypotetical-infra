# (In)fra

This repository contains reusable Terraform modules to provision standardized infrastructure components for different services, including:

- EC2 instances
- Standardized VPC configurations
- Lambda functions for background jobs
- S3 buckets for object storage
- RDS instances for data storage
- ECR repositories for container image storage
- ECS clusters and reusable Fargate services with autoscaling
- Custom VPCs with minimum networking components
- Terraform state buckets for remote state backends

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

## `custom_vpc` module

The `modules/custom_vpc` module creates a custom AWS VPC with the minimum required networking resources to make it operational.

Main features:
- VPC creation with configurable CIDR block
- One or more public subnets across selected Availability Zones
- Optional private subnet creation across selected Availability Zones
- Internet Gateway attachment for internet connectivity
- Public route table with default route (`0.0.0.0/0`) associated to all public subnets
- Useful outputs such as VPC ID/ARN, subnet ID, internet gateway ID, and route table ID

## `ecs_cluster` module

The `modules/ecs_cluster` module creates a reusable AWS ECS cluster that can host multiple services.

Main features:
- ECS cluster provisioning
- Standardized tagging using `Name` and `Environment`
- Useful outputs such as cluster ID, name, and ARN

## `ecs_service` module

The `modules/ecs_service` module creates an AWS ECS Fargate service attached to an existing ECS cluster.

Main features:
- Reusable service deployment to a parent ECS cluster (`cluster_name`)
- Task definition with CloudWatch Logs integration
- Service security group creation with configurable ingress CIDRs
- CPU and memory target-tracking autoscaling policies
- Useful outputs such as service ARN, task definition ARN, and role ARNs

## `tf_state_bucket` module

The `modules/tf_state_bucket` module creates a dedicated S3 bucket for Terraform remote state.

Main features:
- State bucket provisioning with standardized tags
- Versioning enabled for state history
- Server-side encryption enabled (SSE-S3)
- Public access blocked on all dimensions
- Bucket policy denying non-TLS (`aws:SecureTransport = false`) requests
- Optional lifecycle cleanup for noncurrent versions

## Common bootstrap before environment stacks

Use `app/common` to create the Terraform state bucket before running `app/development` or CI/CD deployments.

Example:
1. `terraform -chdir=app/common init`
2. `terraform -chdir=app/common apply -var='tf_state_bucket_name=<globally-unique-bucket-name>'`
3. Set GitHub secrets:
   - `TF_STATE_BUCKET=<globally-unique-bucket-name>`
   - `TF_STATE_REGION=<aws-region>`

## Development environment deployment order

The `app/development` stack intentionally separates infrastructure provisioning from ECS service rollout to avoid deploying tasks before the image exists in ECR.

Workflow:
1. Create base infrastructure only:
   - `terraform -chdir=app/development apply -var='deploy_nginx_service=false'`
2. Build and push the container image to ECR with the intended tag.
3. Deploy ECS service after image exists:
   - `terraform -chdir=app/development apply -var='deploy_nginx_service=true' -var='nginx_image_tag=<tag>'`

When `deploy_nginx_service=true`, Terraform resolves the image digest from ECR and pins ECS to `<repository_url>@<sha256:digest>`.

CI note:
- The GitHub Actions workflow bootstraps only the ECR repository first (`-target=module.sample_web_repository`), pushes the image, and then runs a full apply with `deploy_nginx_service=true` and `nginx_image_tag=<commit_sha>`. This avoids destroying an already-running ECS service on every deployment.
- The workflow uses a persistent Terraform S3 backend. Configure GitHub repository secrets:
  - `TF_STATE_BUCKET`: S3 bucket name for Terraform state.
  - `TF_STATE_REGION`: AWS region where that state bucket exists.
  - `AWS_REGION`: deployment region for infrastructure resources.
  - `AWS_ROLE_TO_ASSUME_ARN`: OIDC assumable role with permissions for Terraform, ECR, ECS, and the state bucket.
- Before the first CI run, migrate any existing local state to S3:
  - `terraform -chdir=app/development init -migrate-state -reconfigure -backend-config="bucket=<TF_STATE_BUCKET>" -backend-config="region=<TF_STATE_REGION>" -backend-config="key=app/development/terraform.tfstate"`
