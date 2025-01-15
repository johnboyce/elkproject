terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "5.83.1"
    }
  }

  required_version = ">= 1.4.0"
}

provider "aws" {
  region = var.region
}

resource "aws_s3_bucket" "remote_state" {
  bucket = "${var.project_name}-terraform-state-${var.environment}"

  server_side_encryption_configuration {
    rule {
      apply_server_side_encryption_by_default {
        sse_algorithm = "AES256"
      }
    }
  }

  tags = {
    Name        = "${var.project_name}-terraform-state"
    Environment = var.environment
    Project     = var.project_name
  }
}

resource "aws_s3_bucket_public_access_block" "remote_state" {
  bucket                  = aws_s3_bucket.remote_state.id
  block_public_acls       = true
  block_public_policy     = true
  ignore_public_acls      = true
  restrict_public_buckets = true
}
