output "db_url" {
  description = "Database host url."
  value       = aws_db_instance.this.address
}

output "db_arn" {
  description = "Amazon Resource Name (ARN) of the database instance."
  value       = aws_db_instance.this.arn
}
