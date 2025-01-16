resource "aws_ecs_task_definition" "this" {
  family                   = "quarkus-app"
  network_mode             = "awsvpc"
  requires_compatibilities = ["FARGATE"]
  cpu                      = "256"
  memory                   = "512"
  execution_role_arn       = var.execution_role_arn
  task_role_arn            = var.task_role_arn

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
        logDriver = "splunk"
        options = {
          splunk-url     = "http://vector:8088" # Vector as Splunk HEC endpoint
          splunk-token   = "VECTOR_SPLUNK_HEC_TOKEN"
          splunk-index   = "quarkus"
          splunk-insecure = "true"
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
