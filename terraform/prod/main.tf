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
  security_group_id = aws_security_group.alb.id
  subnet_ids        = module.vpc.public_subnet_ids
}

resource "aws_security_group" "alb" {
  name        = "elkproject-prod-alb-sg"
  description = "Security group for the ALB in prod"
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
