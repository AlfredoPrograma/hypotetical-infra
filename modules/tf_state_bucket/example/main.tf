provider "aws" {
  region = "us-east-1"
}

module "tf_state_bucket" {
  source = "../"

  bucket_name         = "hypotetical-infra-module-tfstate-example"
  bucket_display_name = "Terraform state bucket module example"
  environment         = "common"
}
