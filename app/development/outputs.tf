output "vpc" {
  description = "Networking outputs from VPC module."
  value = {
    vpc_id              = module.vpc.vpc_id
    vpc_arn             = module.vpc.vpc_arn
    public_subnet_ids   = module.vpc.public_subnet_ids
    private_subnet_ids  = module.vpc.private_subnet_ids
    internet_gateway_id = module.vpc.internet_gateway_id
    public_route_table  = module.vpc.public_route_table_id
  }
}

output "ecr_repository" {
  description = "Container registry outputs."
  value = {
    repository_url = module.sample_web_repository.repository_url
    repository_arn = module.sample_web_repository.repository_arn
  }
}

output "ecs_cluster" {
  description = "ECS cluster outputs."
  value = {
    cluster_id   = module.ecs.cluster_id
    cluster_arn  = module.ecs.cluster_arn
    cluster_name = module.ecs.cluster_name
  }
}

output "nginx_service" {
  description = "Nginx ECS service outputs."
  value = {
    service_name              = module.nginx.service_name
    service_arn               = module.nginx.service_arn
    task_definition_arn       = module.nginx.task_definition_arn
    service_security_group_id = module.nginx.service_security_group_id
    execution_role_arn        = module.nginx.execution_role_arn
    task_role_arn             = module.nginx.task_role_arn
  }
}

output "s3_bucket" {
  description = "S3 bucket outputs."
  value = {
    bucket_url = module.s3_bucket.bucket_url
    bucket_arn = module.s3_bucket.bucket_arn
  }
}

output "platform_summary" {
  description = "High-level summary useful for other stacks and CI pipelines."
  value = {
    environment           = "development"
    region                = var.aws_region
    ecr_repository_url    = module.sample_web_repository.repository_url
    ecs_cluster_name      = module.ecs.cluster_name
    nginx_service_name    = module.nginx.service_name
    nginx_container_image = var.nginx_container_image
    static_assets_bucket  = module.s3_bucket.bucket_url
  }
}
