resource "aws_s3_bucket" "terraform_state" {
  bucket = "${var.application_name}-terraform-state"

  # Prevent Terraform from deleting the bucket
  lifecycle {
    prevent_destroy = true
  }

  tags = {
    Name = "${var.application_name}-state"
  }

  # Conditional logic: Check if the bucket exists before creating
  count = var.skip_bucket_creation ? 0 : 1
}

resource "aws_s3_bucket_server_side_encryption_configuration" "terraform_state_encryption" {
  bucket = aws_s3_bucket.terraform_state.id

  rule {
    apply_server_side_encryption_by_default {
      sse_algorithm = "AES256"
    }
  }
}

resource "aws_s3_bucket_acl" "terraform_state_acl" {
  bucket = aws_s3_bucket.terraform_state.id
  acl    = "private"
}

resource "aws_s3_bucket_versioning" "terraform_state_versioning" {
  bucket = aws_s3_bucket.terraform_state.id

  versioning_configuration {
    status = "Enabled"
  }
}
