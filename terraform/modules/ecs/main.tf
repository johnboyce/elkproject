resource "aws_ecs_cluster" "main" {
  name = "${var.application_name}-ecs-cluster"
}
resource "aws_cloudwatch_log_group" "ecs" {
  name              = "/ecs/elkproject"
  retention_in_days = 7  # Optional: Customize retention period
  tags = {
    Environment = "production"
  }
}