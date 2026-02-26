# custom_vpc module

Terraform module to create a custom AWS VPC with the minimum infrastructure required to operate: one or more public subnets with internet access.

## Usage

```hcl
provider "aws" {
  region = "us-east-1"
}

module "custom_vpc" {
  source = "../"

  vpc_cidr_block   = "10.40.0.0/16"
  vpc_display_name = "Custom VPC module example"
  public_subnets = [
    {
      cidr_block        = "10.40.1.0/24"
      availability_zone = "us-east-1a"
    },
    {
      cidr_block        = "10.40.2.0/24"
      availability_zone = "us-east-1b"
    }
  ]
  private_subnets = [
    {
      cidr_block        = "10.40.10.0/24"
      availability_zone = "us-east-1a"
    }
  ]
  environment              = "development"
}
```

## Inputs

| Name | Type | Required | Default | Description |
|---|---|---|---|---|
| `vpc_cidr_block` | `string` | Yes | `-` | CIDR block for the VPC. |
| `vpc_display_name` | `string` | Yes | `-` | Human-readable VPC display name used for the Name tag. |
| `public_subnets` | `list(object({ cidr_block = string, availability_zone = string }))` | Yes | `-` | List of public subnets to create. At least 1 public subnet is required. |
| `private_subnets` | `list(object({ cidr_block = string, availability_zone = string }))` | No | `[]` | Optional list of private subnets to create. |
| `environment` | `string` | Yes | `-` | Deployment environment for tagging and validation. Allowed values: `development`, `staging`, `production`. |

## Outputs

| Name | Type | Description |
|---|---|---|
| `vpc_id` | `string` | ID of the VPC. |
| `vpc_arn` | `string` | Amazon Resource Name (ARN) of the VPC. |
| `public_subnet_ids` | `list(string)` | IDs of the public subnets. |
| `private_subnet_ids` | `list(string)` | IDs of the private subnets. |
| `internet_gateway_id` | `string` | ID of the internet gateway attached to the VPC. |
| `public_route_table_id` | `string` | ID of the public route table associated with the public subnet. |

## Run the example

From the repository root:

```bash
cd modules/custom_vpc/example
terraform init
terraform plan
terraform apply
```

To remove the created resources:

```bash
terraform destroy
```
