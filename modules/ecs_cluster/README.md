# ecs_cluster module

Terraform module to create an AWS ECS cluster that can host multiple ECS services.

## Usage

```hcl
provider "aws" {
  region = "us-east-1"
}

module "ecs_cluster" {
  source = "../"

  cluster_name         = "hypotetical-ecs-cluster"
  cluster_display_name = "ECS Cluster module example"
  environment          = "development"
}
```

## Inputs

| Name | Type | Required | Default | Description |
|---|---|---|---|---|
| `cluster_name` | `string` | Yes | `-` | ECS cluster name. |
| `cluster_display_name` | `string` | Yes | `-` | Human-readable cluster display name used for the Name tag. |
| `environment` | `string` | Yes | `-` | Deployment environment for tagging and validation. Allowed values: `development`, `staging`, `production`. |

## Outputs

| Name | Type | Description |
|---|---|---|
| `cluster_id` | `string` | ID of the ECS cluster. |
| `cluster_arn` | `string` | Amazon Resource Name (ARN) of the ECS cluster. |
| `cluster_name` | `string` | Name of the ECS cluster. |

## Run the example

From the repository root:

```bash
cd modules/ecs_cluster/example
terraform init
terraform plan
terraform apply
```

To remove the created resources:

```bash
terraform destroy
```
