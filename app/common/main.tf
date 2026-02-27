provider "aws" {
  region = var.aws_region
}

module "tf_state_bucket" {
  source = "../../modules/tf_state_bucket"

  bucket_name                        = var.tf_state_bucket_name
  bucket_display_name                = var.tf_state_bucket_display_name
  environment                        = local.environment
  force_destroy                      = var.tf_state_bucket_force_destroy
  enable_lifecycle_configuration     = var.tf_state_enable_lifecycle_configuration
  noncurrent_version_expiration_days = var.tf_state_noncurrent_version_expiration_days
}
