module "vpc" {
  source = "../modules/vpc"

  cidr_block           = "10.0.0.0/16"
  public_subnet_cidrs  = ["10.0.1.0/24", "10.0.2.0/24"]
  private_subnet_cidrs = ["10.0.101.0/24", "10.0.102.0/24"]
  availability_zones   = ["us-east-1a", "us-east-1b"]

  project_name = "elkproject"
  environment  = "dev"
}

module "ecs_cluster" {
  source = "../modules/ecs_cluster"

  project_name = "elkproject"
  environment  = "dev"
}

module "alb" {
  source = "../modules/alb"

  project_name     = "elkproject"
  environment      = "dev"
  security_group_id = aws_security_group.alb.id
  subnet_ids        = module.vpc.public_subnet_ids
}

resource "aws_security_group" "alb" {
  name        = "elkproject-dev-alb-sg"
  description = "Security group for the ALB"
  vpc_id      = module.vpc.vpc_id

  ingress {
    description = "Allow HTTP traffic"
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    description = "Allow all outbound traffic"
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name        = "elkproject-dev-alb-sg"
    Environment = "dev"
    Project     = "elkproject"
  }
}

module "vector_task" {
  source             = "../modules/vector_task"
  vector_image       = var.vector_image
  execution_role_arn = var.execution_role_arn
  task_role_arn      = var.task_role_arn
  environment        = var.environment
  project_name       = var.project_name
}

module "quarkus_task" {
  source             = "../modules/quarkus_task"
  quarkus_image      = var.quarkus_image
  execution_role_arn = var.execution_role_arn
  task_role_arn      = var.task_role_arn
  environment        = var.environment
  project_name       = var.project_name
  vector_splunk_hec_token = var.vector_splunk_hec_token
}