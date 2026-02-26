output "service_name" {
  description = "Name of the ECS service."
  value       = aws_ecs_service.this.name
}

output "service_arn" {
  description = "Amazon Resource Name (ARN) of the ECS service."
  value       = aws_ecs_service.this.arn
}

output "task_definition_arn" {
  description = "Amazon Resource Name (ARN) of the ECS task definition."
  value       = aws_ecs_task_definition.this.arn
}

output "service_security_group_id" {
  description = "ID of the security group attached to ECS tasks."
  value       = aws_security_group.service.id
}

output "execution_role_arn" {
  description = "Amazon Resource Name (ARN) of the ECS task execution role."
  value       = aws_iam_role.execution.arn
}

output "task_role_arn" {
  description = "Amazon Resource Name (ARN) of the ECS task role."
  value       = aws_iam_role.task.arn
}
