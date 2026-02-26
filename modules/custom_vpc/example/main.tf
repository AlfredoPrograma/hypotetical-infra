provider "aws" {
  region = "us-east-1"
}

module "custom_vpc" {
  source = "../"

  vpc_cidr_block   = "10.40.0.0/16"
  vpc_display_name = "Custom VPC module example"
  public_subnets = [
    {
      cidr_block        = "10.40.1.0/24"
      availability_zone = "us-east-1a"
    },
    {
      cidr_block        = "10.40.2.0/24"
      availability_zone = "us-east-1b"
    }
  ]
  private_subnets = [
    {
      cidr_block        = "10.40.10.0/24"
      availability_zone = "us-east-1a"
    }
  ]
  environment = "development"
}
