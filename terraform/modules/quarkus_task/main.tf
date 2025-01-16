resource "aws_ecs_task_definition" "this" {
  family             = "quarkus-app"
  network_mode       = "awsvpc"
  requires_compatibilities = ["FARGATE"]
  cpu                = "256"
  memory             = "512"
  execution_role_arn = var.execution_role_arn
  task_role_arn      = var.task_role_arn

  container_definitions = jsonencode([
    {
      name      = "quarkus-app"
      image     = var.quarkus_image
      essential = true
      portMappings = [
        {
          containerPort = 8080
          protocol      = "tcp"
        }
      ]
      logConfiguration = {
        logDriver = "awslogs"
        options = {
          awslogs-group         = "quarkus-app"
          awslogs-region        = "us-east-1",
          awslogs-stream-prefix = "ecs"
        }
      }
      }
    }
  ])

  tags = {
    Name        = "quarkus-app"
    Environment = var.environment
    Project     = var.project_name
  }
}
