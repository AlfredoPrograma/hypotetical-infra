# lambda_from_container module

Terraform module to create an AWS Lambda function using a container image.

## Usage

```hcl
provider "aws" {
  region = "us-east-1"
}

module "lambda_from_container" {
  source = "../"

  function_name     = "hypotetical-container-lambda"
  function_role_arn = "arn:aws:iam::123456789012:role/lambda-execution-role"
  image_uri         = "123456789012.dkr.ecr.us-east-1.amazonaws.com/hypotetical-ecr-repository:latest"
}
```

## Inputs

| Name | Type | Required | Default | Description |
|---|---|---|---|---|
| `function_name` | `string` | Yes | `-` | Lambda function name. |
| `function_role_arn` | `string` | Yes | `-` | IAM role ARN assumed by the Lambda function. |
| `image_uri` | `string` | Yes | `-` | Container image URI used by the Lambda function. |

## Outputs

| Name | Type | Description |
|---|---|---|
| `function_name` | `string` | Name of the Lambda function. |
| `function_arn` | `string` | Amazon Resource Name (ARN) of the Lambda function. |
| `invoke_arn` | `string` | Invoke ARN of the Lambda function. |

## Run the example

From the repository root:

```bash
cd modules/lambda_from_container/example
export TF_VAR_function_role_arn='arn:aws:iam::123456789012:role/lambda-execution-role'
export TF_VAR_image_uri='123456789012.dkr.ecr.us-east-1.amazonaws.com/hypotetical-ecr-repository:latest'
terraform init
terraform plan
terraform apply
```

To remove the created resources:

```bash
terraform destroy
```
