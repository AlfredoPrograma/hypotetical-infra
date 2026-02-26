# ecs_service module

Terraform module to create a reusable AWS ECS Fargate service with autoscaling, attached to an existing parent ECS cluster.

## Usage

```hcl
provider "aws" {
  region = "us-east-1"
}

module "ecs_service" {
  source = "../"

  cluster_name    = "hypotetical-ecs-cluster"
  service_name    = "hypotetical-ecs-web-service"
  container_name  = "web"
  container_image = "nginx:latest"
  container_port  = 80
  aws_region      = "us-east-1"
  vpc_id          = "vpc-xxxxxxxx"
  subnet_ids      = ["subnet-xxxxxxxx", "subnet-yyyyyyyy"]
  environment     = "development"
}
```

You can reuse this module multiple times against the same cluster:

```hcl
module "ecs_service_web" {
  source = "../"
  # ...
  cluster_name = module.ecs_cluster.cluster_name
  service_name = "web-service"
}

module "ecs_service_api" {
  source = "../"
  # ...
  cluster_name = module.ecs_cluster.cluster_name
  service_name = "api-service"
}
```

## Inputs

| Name | Type | Required | Default | Description |
|---|---|---|---|---|
| `cluster_name` | `string` | Yes | `-` | Name of the parent ECS cluster where the service will run. |
| `service_name` | `string` | Yes | `-` | ECS service name. |
| `container_name` | `string` | Yes | `-` | Container name used in the task definition. |
| `container_image` | `string` | Yes | `-` | Container image URI for the service. |
| `aws_region` | `string` | Yes | `-` | AWS region used by container log configuration. |
| `vpc_id` | `string` | Yes | `-` | VPC ID where the ECS service security group is created. |
| `subnet_ids` | `set(string)` | Yes | `-` | Subnet IDs used by the ECS service network configuration. |
| `environment` | `string` | Yes | `-` | Deployment environment for tagging and validation. Allowed values: `development`, `staging`, `production`. |
| `container_port` | `number` | No | `80` | Exposed TCP port for the container. |
| `task_cpu` | `number` | No | `256` | CPU units for the Fargate task definition. |
| `task_memory` | `number` | No | `512` | Memory (MiB) for the Fargate task definition. |
| `desired_count` | `number` | No | `1` | Initial desired number of running tasks. |
| `min_capacity` | `number` | No | `1` | Minimum number of tasks for autoscaling. |
| `max_capacity` | `number` | No | `3` | Maximum number of tasks for autoscaling. |
| `cpu_target_value` | `number` | No | `70` | Target average CPU utilization percentage for autoscaling. |
| `memory_target_value` | `number` | No | `75` | Target average memory utilization percentage for autoscaling. |
| `ingress_cidr_blocks` | `list(string)` | No | `["0.0.0.0/0"]` | CIDR blocks allowed to access the container port. |
| `assign_public_ip` | `bool` | No | `true` | Whether to assign a public IP to tasks. |
| `log_retention_in_days` | `number` | No | `7` | CloudWatch log retention period in days. |
| `s3_bucket_arns` | `list(string)` | No | `[]` | S3 bucket ARNs the ECS task role can access. |
| `s3_actions` | `list(string)` | No | `["s3:GetObject","s3:PutObject","s3:DeleteObject","s3:ListBucket"]` | IAM S3 actions allowed for the ECS task role. |

## Outputs

| Name | Type | Description |
|---|---|---|
| `service_name` | `string` | Name of the ECS service. |
| `service_arn` | `string` | Amazon Resource Name (ARN) of the ECS service. |
| `task_definition_arn` | `string` | Amazon Resource Name (ARN) of the ECS task definition. |
| `service_security_group_id` | `string` | ID of the security group attached to ECS tasks. |
| `execution_role_arn` | `string` | Amazon Resource Name (ARN) of the ECS task execution role. |
| `task_role_arn` | `string` | Amazon Resource Name (ARN) of the ECS task role. |

## Run the example

From the repository root:

```bash
cd modules/ecs_service/example
export TF_VAR_vpc_id='vpc-xxxxxxxx'
export TF_VAR_subnet_ids='["subnet-xxxxxxxx", "subnet-yyyyyyyy"]'
terraform init
terraform plan
terraform apply
```

To remove the created resources:

```bash
terraform destroy
```
