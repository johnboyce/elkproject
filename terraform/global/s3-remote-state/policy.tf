resource "aws_s3_bucket_policy" "remote_state" {
  bucket = aws_s3_bucket.remote_state.id

  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Sid       = "AllowRootAccountAccess"
        Effect    = "Allow"
        Principal = { AWS = "arn:aws:iam::${data.aws_caller_identity.current.account_id}:root" }
        Action    = "s3:*"
        Resource  = [
          "arn:aws:s3:::${aws_s3_bucket.remote_state.id}",
          "arn:aws:s3:::${aws_s3_bucket.remote_state.id}/*"
        ]
      }
    ]
  })
}

data "aws_caller_identity" "current" {}
