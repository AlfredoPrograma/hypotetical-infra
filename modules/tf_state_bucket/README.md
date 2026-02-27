# tf_state_bucket module

Terraform module to create a hardened S3 bucket for Terraform remote state.

## Usage

```hcl
provider "aws" {
  region = "us-east-1"
}

module "tf_state_bucket" {
  source = "../"

  bucket_name         = "hypotetical-infra-tf-state-bucket"
  bucket_display_name = "Terraform State Bucket"
  environment         = "common"
}
```

## Inputs

| Name | Type | Required | Default | Description |
|---|---|---|---|---|
| `bucket_name` | `string` | Yes | `-` | Globally unique S3 bucket name used to store Terraform state files. |
| `bucket_display_name` | `string` | Yes | `-` | Human-readable bucket display name used for the Name tag. |
| `environment` | `string` | No | `"common"` | Environment tag value attached to resources. |
| `force_destroy` | `bool` | No | `false` | Whether to allow bucket deletion even when it contains objects. Keep false for safety in production. |
| `enable_lifecycle_configuration` | `bool` | No | `true` | Whether to create lifecycle configuration for noncurrent object versions. |
| `noncurrent_version_expiration_days` | `number` | No | `30` | Days to retain noncurrent object versions in the state bucket. |

## Outputs

| Name | Type | Description |
|---|---|---|
| `bucket_name` | `string` | Name of the Terraform state S3 bucket. |
| `bucket_arn` | `string` | Amazon Resource Name (ARN) of the Terraform state bucket. |
| `bucket_domain_name` | `string` | Bucket domain name. |

## Run the example

From the repository root:

```bash
cd modules/tf_state_bucket/example
terraform init
terraform plan
terraform apply
```

To remove the created resources:

```bash
terraform destroy
```
