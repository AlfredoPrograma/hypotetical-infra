provider "aws" {
  region = var.aws_region
}

module "vpc" {
  source = "../../modules/custom_vpc"

  environment      = local.environment
  vpc_display_name = var.vpc_display_name
  vpc_cidr_block   = var.vpc_cidr_block
  public_subnets   = var.public_subnets
  private_subnets  = var.private_subnets
}

module "sample_web_repository" {
  source = "../../modules/ecr_repository"

  environment             = local.environment
  repository_display_name = var.repository_display_name
  repository_name         = var.repository_name
}

module "ecs" {
  source = "../../modules/ecs_cluster"

  environment          = local.environment
  cluster_display_name = var.cluster_display_name
  cluster_name         = var.cluster_name
}

module "nginx" {
  source = "../../modules/ecs_service"

  environment         = local.environment
  vpc_id              = module.vpc.vpc_id
  assign_public_ip    = var.nginx_assign_public_ip
  aws_region          = var.aws_region
  cluster_name        = module.ecs.cluster_name
  container_image     = var.nginx_container_image
  container_name      = var.nginx_container_name
  service_name        = var.nginx_service_name
  subnet_ids          = module.vpc.public_subnet_ids
  container_port      = var.nginx_container_port
  ingress_cidr_blocks = var.nginx_ingress_cidr_blocks
  s3_bucket_arns      = [module.s3_bucket.bucket_arn]
  s3_actions          = var.nginx_s3_actions
}

module "s3_bucket" {
  source = "../../modules/s3_bucket"

  environment               = local.environment
  bucket_name               = var.bucket_name
  bucket_display_name       = var.bucket_display_name
  bucket_cors_configuration = var.bucket_cors_configuration
  block_public_access       = var.s3_block_public_access
}
