output "s3_bucket_name" {
  description = "The name of the S3 bucket used for remote state"
  value       = aws_s3_bucket.remote_state.id
}
