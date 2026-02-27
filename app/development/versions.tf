terraform {
  required_version = "1.14.2"

  backend "s3" {
    key          = "app/development/terraform.tfstate"
    encrypt      = true
    use_lockfile = true
  }

  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "6.33"
    }
  }
}
