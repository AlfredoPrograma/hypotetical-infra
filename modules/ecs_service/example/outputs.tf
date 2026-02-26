output "cluster_name" {
  description = "Name of the ECS cluster."
  value       = module.ecs_cluster.cluster_name
}

output "service_name" {
  description = "Name of the ECS service."
  value       = module.ecs_service_web.service_name
}

output "service_arn" {
  description = "Amazon Resource Name (ARN) of the ECS service."
  value       = module.ecs_service_web.service_arn
}

output "task_definition_arn" {
  description = "Amazon Resource Name (ARN) of the ECS task definition."
  value       = module.ecs_service_web.task_definition_arn
}

output "service_security_group_id" {
  description = "ID of the security group attached to ECS tasks."
  value       = module.ecs_service_web.service_security_group_id
}
