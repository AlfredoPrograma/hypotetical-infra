# app/common

Bootstrap stack for shared infrastructure required before environment stacks.

## Purpose

Creates the Terraform remote state S3 bucket used by CI/CD and `app/development` backend initialization.

## Usage

```bash
terraform -chdir=app/common init
terraform -chdir=app/common apply \
  -var='tf_state_bucket_name=<globally-unique-bucket-name>' \
  -var='github_actions_role_name=<github-actions-role-name>' \
  -var='github_oidc_provider_arn=<github-oidc-provider-arn>' \
  -var='github_repository=<owner/repo>'
```

Useful output:

- `tf_state_bucket.bucket_name`
- `tf_state_bucket.region`
- `github_actions_oidc_role.role_arn`

Use those values for GitHub repository secrets:

- `TF_STATE_BUCKET`
- `TF_STATE_REGION`
- `AWS_ROLE_TO_ASSUME_ARN`
