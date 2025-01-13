resource "aws_ecr_repository" "vector" {
  name = "vector"

  image_scanning_configuration {
    scan_on_push = true
  }

  encryption_configuration {
    encryption_type = "AES256"
  }

  tags = {
    Environment = var.environment
    Application = "Vector"
  }
}