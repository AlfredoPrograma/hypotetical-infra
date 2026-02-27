# app/common

Bootstrap stack for shared infrastructure required before environment stacks.

## Purpose

Creates the Terraform remote state S3 bucket used by CI/CD and `app/development` backend initialization.

## Usage

```bash
terraform -chdir=app/common init
terraform -chdir=app/common apply -var='tf_state_bucket_name=<globally-unique-bucket-name>'
```

Useful output:

- `tf_state_bucket.bucket_name`
- `tf_state_bucket.region`

Use those values for GitHub repository secrets:

- `TF_STATE_BUCKET`
- `TF_STATE_REGION`
