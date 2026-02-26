resource "aws_ecr_repository" "this" {
  name                 = var.repository_name
  image_tag_mutability = "IMMUTABLE"
  force_delete         = false

  encryption_configuration {
    encryption_type = var.encryption_key_arn != null ? "KMS" : "AES256"
    kms_key         = var.encryption_key_arn
  }

  tags = {
    Name        = var.repository_display_name
    Environment = var.environment
  }
}
