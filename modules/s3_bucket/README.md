# s3_bucket module

Terraform module to create and standardize an AWS S3 bucket with baseline security controls and optional CORS configuration.

## Usage

```hcl
provider "aws" {
  region = "us-east-1"
}

module "s3_bucket" {
  source = "../"

  bucket_name         = "hypotetical-infra-module-s3bucket-example"
  bucket_display_name = "S3 Bucket module example"
  environment          = "development"
  block_public_access  = true

  bucket_cors_configuration = [
    {
      headers         = ["*"]
      methods         = ["GET", "PUT"]
      origins         = ["https://hypotetical-company.com"]
      expiration_time = 3000
    }
  ]
}
```

## Inputs

| Name | Type | Required | Default | Description |
|---|---|---|---|---|
| `bucket_name` | `string` | Yes | `-` | Globally unique S3 bucket name. Must satisfy AWS S3 bucket naming rules. |
| `bucket_display_name` | `string` | Yes | `-` | Human-readable bucket display name used for the Name tag. |
| `environment` | `string` | Yes | `-` | Deployment environment for tagging and validation. Allowed values: `development`, `staging`, `production`. |
| `bucket_cors_configuration` | `list(object({ headers = list(string), methods = list(string), origins = list(string), expiration_time = number }))` | Yes | `-` | List of CORS rules to apply to the bucket. If empty, no CORS configuration is created. |
| `block_public_access` | `bool` | No | `false` | Whether to create an S3 Public Access Block configuration for this bucket. |
| `encryption_key_arn` | `string` | No | `null` | KMS key ARN intended for SSE-KMS encryption. Currently unused by this module; encryption is configured as SSE-S3 (AES256). |

## Outputs

| Name | Type | Description |
|---|---|---|
| `bucket_url` | `string` | S3 bucket domain name. |
| `bucket_arn` | `string` | Amazon Resource Name (ARN) of the S3 bucket. |

## Run the example

From the repository root:

```bash
cd modules/s3_bucket/example
terraform init
terraform plan
terraform apply
```

To remove the created resources:

```bash
terraform destroy
```
