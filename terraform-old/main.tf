terraform {
  backend "s3" {
    bucket  = "elkproject-terraform-state"
    key     = "global/s3/terraform.tfstate"
    region  = "us-east-1"
    encrypt = true
  }
}

provider "aws" {
  region = var.aws_region
}

# VPC Module
module "vpc" {
  source           = "./modules/vpc"
  application_name = var.application_name
}

# Subnets Module
module "subnets" {
  source              = "./modules/subnets"
  vpc_id              = module.vpc.vpc_id
  vpc_cidr            = "10.0.0.0/16"
  application_name    = var.application_name
  internet_gateway_id = module.vpc.internet_gateway_id
}

module "security_groups" {
  source           = "./modules/security_groups"
  vpc_id           = module.vpc.vpc_id
  application_name = var.application_name
}

module "iam" {
  source           = "./modules/iam"
  application_name = var.application_name
}

module "ecs" {
  source                      = "./modules/ecs"
  application_name            = var.application_name
  vpc_id                      = module.vpc.vpc_id
  subnets                     = module.subnets.public_subnets
  ecs_task_role_arn           = module.iam.ecs_task_role_arn
  ecs_task_execution_role_arn = module.iam.ecs_task_execution_role_arn
}

module "alb" {
  source           = "./modules/alb"
  application_name = var.application_name
  vpc_id           = module.vpc.vpc_id
  subnets          = module.subnets.public_subnets
  security_groups = [module.security_groups.alb_sg_id]
}

module "vector_ecr" {
  source          = "./modules/ecr"
  repository_name = var.vector_ecr_name
  environment     = var.environment
  region          = var.region
}

module "elasticsearch_ecr" {
  source          = "./modules/ecr"
  repository_name = var.elasticsearch_ecr_name
  environment     = var.environment
  region          = var.region
}

module "vector_task_definition" {
  source             = "./modules/ecs_task_definition"
  family             = "vector"
  execution_role_arn = module.iam.ecs_task_execution_role_arn
  task_role_arn      = module.iam.ecs_task_role_arn
  cpu                = "256"
  memory             = "512"
  container_name     = "vector"
  image              = "${module.vector_ecr.repository_url}:latest"
  port_mappings = [
    {
      containerPort = 8686
      protocol      = "tcp"
    }
  ]
  log_group         = "/ecs/elkproject"
  log_stream_prefix = "ecs"
  aws_region        = var.aws_region
}

resource "aws_ecs_service" "elkproject-service" {
  cluster                            = module.ecs.cluster_arn
  deployment_maximum_percent         = 200
  deployment_minimum_healthy_percent = 100
  desired_count                      = 1
  enable_ecs_managed_tags            = false
  enable_execute_command             = false
  health_check_grace_period_seconds  = 0
  iam_role                           = "/aws-service-role/ecs.amazonaws.com/AWSServiceRoleForECS"
  launch_type                        = "FARGATE"
  name                               = "elkproject-service"
  platform_version                   = "LATEST"
  propagate_tags                     = "NONE"
  scheduling_strategy                = "REPLICA"
  tags = {}
  tags_all = {}
  task_definition                    = "elkproject:5"
  triggers = {}

  deployment_circuit_breaker {
    enable   = false
    rollback = false
  }

  deployment_controller {
    type = "ECS"
  }

  load_balancer {
    container_name   = "elkproject-container"
    container_port   = 8080
    target_group_arn = module.alb.target_group_arn
  }

  network_configuration {
    assign_public_ip = true
    security_groups = [module.security_groups.ecs_tasks_sg_id, module.security_groups.ecs_tasks_sg_id]
    subnets = [module.subnets.public_subnets[0], module.subnets.public_subnets[1]]
  }
}
