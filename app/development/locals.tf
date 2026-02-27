locals {
  environment           = "development"
  nginx_container_image = var.deploy_nginx_service ? "${module.sample_web_repository.repository_url}@${data.aws_ecr_image.nginx[0].image_digest}" : null
}
