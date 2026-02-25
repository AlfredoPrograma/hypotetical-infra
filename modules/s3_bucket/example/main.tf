provider "aws" {
  region = "us-east-1"
}

module "s3_bucket" {
  source = "../"

  bucket_name         = "hypotetical-infra-module-s3bucket-example"
  bucket_display_name = "S3 Bucket module example"
  block_public_access = true
  bucket_cors_configuration = [
    {
      headers         = ["*"],
      methods         = ["GET", "PUT"],
      origins         = ["https://hypotetical-company.com"]
      expiration_time = 3000
    }
  ]
  environment = "development"
}
