provider "aws" {
  region = "us-east-1"
}

module "ecr_repository" {
  source = "../"

  repository_name         = "hypotetical-ecr-repository"
  repository_display_name = "ECR Repository example"
  environment             = "development"
}
