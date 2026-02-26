# rds_postgres module

Terraform module to create and standardize an AWS RDS PostgreSQL instance with secure defaults for networking, encryption, backups, and monitoring.

## Usage

```hcl
provider "aws" {
  region = "us-east-1"
}

module "rds_postgres" {
  source = "../"

  db_display_name   = "RDS Postgres database example"
  db_instance_class = "db.t3.micro"
  db_name           = "hypoteticaldb"
  db_storage_amount = 55
  db_username       = "hypotetical-user"
  db_password       = var.db_password
  postgres_version  = "18.1"
  subnet_ids        = ["subnet-05a81b6fbbb248feb", "subnet-0276dd93f7f6d862d"]
  environment       = "development"
}
```

## Inputs

| Name | Type | Required | Default | Description |
|---|---|---|---|---|
| `db_name` | `string` | Yes | `-` | Database name. It is also used as the RDS instance identifier and final snapshot identifier. |
| `db_username` | `string` | Yes | `-` | Indicates the database username. |
| `db_password` | `string` | Yes | `-` | Indicates database password. |
| `db_display_name` | `string` | Yes | `-` | A Human readable name for identifying database. |
| `subnet_ids` | `set(string)` | Yes | `-` | Indicates the subnet ids that will be used to host the database. At least 2 subnets are required. |
| `environment` | `string` | Yes | `-` | Deployment environment for tagging and validation. Allowed values: `development`, `staging`, `production`. |
| `postgres_version` | `string` | No | `18.2` | Indicates Postgres engine version. |
| `db_storage_amount` | `number` | No | `80` | Indicates the storage allocation amount in Gigabytes. |
| `db_instance_class` | `string` | No | `db.t3.micro` | Indicates AWS instance class for database hosting. |
| `encryption_key_arn` | `string` | No | `null` | Indicates the KMS key ARN for custom encryption. If `null`, the default AWS encryption key is used. |
| `vpc_security_groups_ids` | `set(string)` | No | `[]` | Indicates the security group ids that will be applied to the database. |

## Outputs

| Name | Type | Description |
|---|---|---|
| `db_url` | `string` | Database host url. |
| `db_arn` | `string` | Amazon Resource Name (ARN) of the database instance. |

## Run the example

From the repository root:

```bash
cd modules/rds_postgres/example
export TF_VAR_db_password='your-secure-password'
terraform init
terraform plan
terraform apply
```

To remove the created resources:

```bash
terraform destroy
```
