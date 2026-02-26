resource "aws_db_subnet_group" "this" {
  name       = var.db_name
  subnet_ids = var.subnet_ids

  tags = {
    Name        = "${var.db_name}-db-subnet-group"
    Environment = var.environment
  }
}

resource "aws_db_instance" "this" {
  engine                          = "postgres"
  deletion_protection             = true
  skip_final_snapshot             = false
  publicly_accessible             = false
  storage_encrypted               = true
  allow_major_version_upgrade     = false
  auto_minor_version_upgrade      = true
  performance_insights_enabled    = true
  enabled_cloudwatch_logs_exports = ["postgresql"]
  backup_retention_period         = 15
  db_subnet_group_name            = aws_db_subnet_group.this.name
  final_snapshot_identifier       = var.db_name
  identifier                      = var.db_name
  vpc_security_group_ids          = var.vpc_security_groups_ids
  engine_version                  = var.postgres_version
  allocated_storage               = var.db_storage_amount
  db_name                         = var.db_name
  instance_class                  = var.db_instance_class
  username                        = var.db_username
  password                        = var.db_password
  kms_key_id                      = var.encryption_key_arn

  tags = {
    Name        = var.db_display_name
    Environment = var.environment
  }
}
