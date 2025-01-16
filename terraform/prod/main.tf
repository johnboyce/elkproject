module "vpc" {
  source = "../modules/vpc"

  cidr_block           = "10.1.0.0/16" # Adjusted CIDR for prod
  public_subnet_cidrs  = ["10.1.1.0/24", "10.1.2.0/24"]
  private_subnet_cidrs = ["10.1.101.0/24", "10.1.102.0/24"]
  availability_zones   = ["us-east-1a", "us-east-1b"]

  project_name = "elkproject"
  environment  = "prod"
}

module "ecs_cluster" {
  source = "../modules/ecs_cluster"

  project_name = "elkproject"
  environment  = "prod"
}

module "alb" {
  source = "../modules/alb"

  project_name      = "elkproject"
  environment       = "prod"
  vpc_id            = module.vpc.vpc_id
  security_group_id = aws_security_group.alb.id
  subnet_ids        = module.vpc.public_subnet_ids
}

module "security_groups" {
  source       = "../modules/security_groups"
  vpc_id       = module.vpc.vpc_id
  project_name = "elkproject"
  environment  = "prod"
}

module "ecs_service_quarkus" {
  source              = "../modules/ecs_service_quarkus"
  project_name        = "elkproject"
  environment         = "prod"
  ecs_cluster_id      = module.ecs_cluster.id
  task_definition_arn = module.quarkus_task.arn
  subnet_ids          = module.vpc.private_subnets
  security_group_id   = module.security_groups.service_security_group
  target_group_arn    = module.alb.quarkus_target_group_arn
}

resource "aws_security_group" "alb" {
  name        = "elkproject-prod-alb-sg"
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
    Name        = "elkproject-prod-alb-sg"
    Environment = "prod"
    Project     = "elkproject"
  }
}

module "iam" {
  source       = "../modules/iam"
  project_name = "elkproject"
  environment  = "prod"
}

module "vector_task" {
  source             = "../modules/vector_task"
  vector_image       = var.vector_image
  execution_role_arn = module.iam.ecs_execution_role_arn
  task_role_arn      = module.iam.ecs_task_role_arn
  environment        = var.environment
  project_name       = var.project_name
}

module "quarkus_task" {
  source             = "../modules/quarkus_task"
  quarkus_image      = var.quarkus_image
  execution_role_arn = module.iam.ecs_execution_role_arn
  task_role_arn      = module.iam.ecs_task_role_arn
  environment        = var.environment
  project_name       = var.project_name
  vector_splunk_hec_token = var.vector_splunk_hec_token
}
