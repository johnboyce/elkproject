# ALB Security Group
resource "aws_security_group" "alb" {
  name        = "${var.application_name}-alb-sg"
  description = "Security group for ALB"
  vpc_id      = var.vpc_id

  ingress {
    description = "Allow HTTP traffic"
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    description = "Allow HTTPS traffic"
    from_port   = 443
    to_port     = 443
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "${var.application_name}-alb-sg"
    Environment = "production"
  }
}

# ECS Task Security Group
resource "aws_security_group" "ecs_tasks" {
  name        = "${var.application_name}-ecs-tasks-sg"
  description = "Security group for ECS tasks"
  vpc_id      = var.vpc_id

  ingress {
    description = "Allow inbound from ALB"
    from_port   = 8080
    to_port     = 8080
    protocol    = "tcp"
    source_security_group_id = aws_security_group.alb.id
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "${var.application_name}-ecs-tasks-sg"
    Environment = "production"
  }
}

# General Security Group for Private Resources
resource "aws_security_group" "private_resources" {
  name        = "${var.application_name}-private-resources-sg"
  description = "Security group for private resources"
  vpc_id      = var.vpc_id

  ingress {
    description = "Allow inbound from ECS tasks"
    from_port   = 9200
    to_port     = 9300
    protocol    = "tcp"
    source_security_group_id = aws_security_group.ecs_tasks.id
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "${var.application_name}-private-resources-sg"
    Environment = "production"
  }
}
