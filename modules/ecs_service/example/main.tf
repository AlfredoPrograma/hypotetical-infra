provider "aws" {
  region = "us-east-1"
}

module "ecs_cluster" {
  source = "../../ecs_cluster"

  cluster_name         = "hypotetical-ecs-cluster"
  cluster_display_name = "ECS Cluster module example"
  environment          = "development"
}

module "ecs_service_web" {
  source = "../"

  cluster_name    = module.ecs_cluster.cluster_name
  service_name    = "hypotetical-ecs-web-service"
  container_name  = "web"
  container_image = "nginx:latest"
  container_port  = 80
  aws_region      = "us-east-1"
  vpc_id          = var.vpc_id
  subnet_ids      = var.subnet_ids
  environment     = "development"
}
