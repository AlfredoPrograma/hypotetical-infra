provider "aws" {
  region = "us-east-1"
}

module "lambda_from_container" {
  source = "../"

  function_name     = "hypotetical-container-lambda"
  function_role_arn = var.function_role_arn
  image_uri         = var.image_uri
}
