resource "aws_cloudwatch_log_group" "quarkus_app" {
  name              = "/ecs/quarkus-app"
  retention_in_days = 7 # Set log retention as needed
  tags = {
    Name        = "/ecs/quarkus-app"
    Environment = var.environment
  }
}
