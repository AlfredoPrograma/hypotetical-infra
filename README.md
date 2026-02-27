# (In)fra

This repo contains reusable Terraform modules that we use to provision standard infrastructure across services.

Instead of rebuilding everything from scratch every time, these modules give us a consistent way to spin up the basics in AWS.

It currently covers:

* Standard VPC setups
* Lambda functions for background jobs
* S3 buckets
* RDS databases
* ECR repositories
* ECS clusters with reusable Fargate services (including autoscaling)
* Terraform state buckets for remote backends

The goal is simple: make infrastructure predictable and repeatable, aligned with the internal **(In)fra** standards.

## Deployment

### Prerequisites

Before running anything, make sure you have:

* An AWS account
* GitHub OIDC provider configured (`token.actions.githubusercontent.com`)
* Terraform `1.14.2`
* Permissions for `app/common` and `app/development`
* Proper environment values set in `.tfvars` files (e.g. `app/common/terraform.tfvars`)

### 1. Create Shared Infrastructure

This sets up the shared components (including remote state).

```bash
terraform -chdir=app/common init
terraform -chdir=app/common apply
```

### 2. Configure GitHub Secrets

Add the following secrets in your repository:

* `TF_STATE_BUCKET`
* `TF_STATE_REGION`
* `AWS_REGION`
* `AWS_ROLE_TO_ASSUME_ARN`

These are used by GitHub Actions to authenticate via OIDC and assume the correct IAM role (no static AWS keys required).

### 3. Deploy Base Infrastructure

Initialize Terraform with the shared backend:

```bash
terraform -chdir=app/development init -reconfigure \
  -backend-config="bucket=<TF_STATE_BUCKET>" \
  -backend-config="region=<TF_STATE_REGION>" \
  -backend-config="key=app/development/terraform.tfstate"

terraform -chdir=app/development apply
```

This provisions the environment-level infrastructure.

### 4. Push Image and Deploy Service

After building and pushing your Docker image to ECR, run:

```bash
terraform -chdir=app/development apply
```

Terraform updates the ECS service with the new image.

### 5. CI/CD

CI/CD runs from:

```
.github/workflows/sample-web-deployment.yaml
```

On pushes to `main`, GitHub Actions:

* Authenticates using OIDC
* Assumes the configured IAM role
* Runs Terraform
* Deploys the service

## Terraform State (Team Usage)

We use a shared S3 backend for Terraform state.

The state bucket:

* Has versioning enabled
* Is encrypted
* Blocks public access

All developers and CI use the same backend configuration.

If you're migrating from local state, run:

```bash
terraform init -migrate-state
```

After that, avoid local state files.

## Why This Setup

The stack is intentionally simple and practical:

* Terraform modules reduce repetition
* ECS + ECR provide a managed container platform with minimal ops overhead
* GitHub Actions + OIDC eliminate long-lived AWS credentials
* S3 remote state keeps collaboration straightforward

The aim is to ship production ready infrastructure quickly without overengineering things.
