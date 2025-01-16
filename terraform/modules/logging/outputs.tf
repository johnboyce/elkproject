output "quarkus_log_group_name" {
  description = "The name of the CloudWatch Log Group for the Quarkus app"
  value       = aws_cloudwatch_log_group.quarkus_app.name
}