provider "aws" {
  region = "us-east-1"
}

module "rds_postgres" {
  source = "../"

  db_display_name   = "RDS Postgres database example"
  db_instance_class = "db.t3.micro"
  db_name           = "hypoteticaldb"
  db_storage_amount = 55
  db_username       = "hypoteticaluser"
  environment       = "development"
  postgres_version  = "18.1"
  subnet_ids        = ["subnet-05a81b6fbbb248feb", "subnet-0276dd93f7f6d862d"]
  db_password       = var.db_password
}
