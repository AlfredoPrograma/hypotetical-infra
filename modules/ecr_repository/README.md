# ecr_repository module

Terraform module to create and standardize an AWS ECR repository with immutable tags, encryption, and environment tagging.

## Usage

```hcl
provider "aws" {
  region = "us-east-1"
}

module "ecr_repository" {
  source = "../"

  repository_name         = "hypotetical-ecr-repository"
  repository_display_name = "ECR Repository example"
  environment             = "development"
}
```

## Inputs

| Name | Type | Required | Default | Description |
|---|---|---|---|---|
| `repository_name` | `string` | Yes | `-` | Globally unique ECR repository name. |
| `repository_display_name` | `string` | Yes | `-` | Human-readable repository display name used for the Name tag. |
| `environment` | `string` | Yes | `-` | Deployment environment for tagging and validation. Allowed values: `development`, `staging`, `production`. |
| `encryption_key_arn` | `string` | No | `null` | KMS key ARN used to encrypt the repository. If `null`, default ECR encryption (AES256) is used. |

## Outputs

| Name | Type | Description |
|---|---|---|
| `repository_url` | `string` | ECR repository URL used to push and pull container images. |
| `repository_arn` | `string` | Amazon Resource Name (ARN) of the ECR repository. |

## Run the example

From the repository root:

```bash
cd modules/ecr_repository/example
terraform init
terraform plan
terraform apply
```

To remove the created resources:

```bash
terraform destroy
```
