resource "aws_ecs_service" "quarkus_service" {
  name            = "${var.project_name}-${var.environment}-quarkus-service"
  cluster         = var.ecs_cluster_id
  task_definition = var.task_definition_arn
  desired_count   = 1
  launch_type     = "FARGATE"

  network_configuration {
    subnets         = var.public_subnets # Use public subnets
    security_groups = [var.security_group_id]
    assign_public_ip = true # Assign public IP to ECS tasks
  }

  load_balancer {
    target_group_arn = var.target_group_arn
    container_name   = "quarkus-app"
    container_port   = 8080
  }

  tags = {
    Name        = "${var.project_name}-${var.environment}-quarkus-service"
    Environment = var.environment
  }
}
