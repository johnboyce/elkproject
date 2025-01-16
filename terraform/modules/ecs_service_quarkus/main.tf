resource "aws_ecs_service" "quarkus_service" {
  name            = "${var.project_name}-${var.environment}-quarkus-service"
  cluster         = var.ecs_cluster_id
  task_definition = var.task_definition_arn
  desired_count   = 1
  launch_type     = "FARGATE"

  # Network configuration
  network_configuration {
    subnets         = var.subnet_ids
    security_groups = [var.security_group_id]
    assign_public_ip = false
  }

  # ALB integration
  load_balancer {
    target_group_arn = var.target_group_arn
    container_name   = "quarkus-app"
    container_port   = 8080
  }

  deployment_controller {
    type = "ECS"
  }

  tags = {
    Name        = "${var.project_name}-${var.environment}-quarkus-service"
    Environment = var.environment
  }
}
