provider "aws" {
  region = "us-east-1"
}

module "ecs_cluster" {
  source = "../"

  cluster_name         = "hypotetical-ecs-cluster"
  cluster_display_name = "ECS Cluster module example"
  environment          = "development"
}
