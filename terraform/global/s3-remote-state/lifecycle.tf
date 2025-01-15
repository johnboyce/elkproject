resource "aws_s3_bucket_lifecycle_configuration" "remote_state" {
  bucket = aws_s3_bucket.remote_state.id

  rule {
    id     = "cleanup-old-versions"
    status = "Enabled"

    noncurrent_version_expiration {
      noncurrent_days = 90
    }
  }
}
