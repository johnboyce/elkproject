resource "aws_ecs_task_definition" "this" {
  family                   = "vector"
  network_mode             = "awsvpc"
  requires_compatibilities = ["FARGATE"]
  cpu                      = "256"
  memory                   = "512"
  execution_role_arn       = var.execution_role_arn
  task_role_arn            = var.task_role_arn

  container_definitions = jsonencode([
    {
      name      = "vector"
      image     = var.vector_image
      essential = true
      portMappings = [
        {
          containerPort = 8088
          protocol      = "tcp"
        }
      ]
    }
  ])

  tags = {
    Name        = "vector"
    Environment = var.environment
    Project     = var.project_name
  }
}
