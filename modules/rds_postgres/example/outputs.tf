output "db_url" {
  description = "Database host url."
  value       = module.rds_postgres.db_url
}

output "db_arn" {
  description = "Amazon Resource Name (ARN) of the database instance."
  value       = module.rds_postgres.db_arn
}
