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
  source           = "./modules/subnets"
  vpc_id           = module.vpc.vpc_id
  vpc_cidr         = "10.0.0.0/16"
  application_name = var.application_name
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
  source           = "./modules/ecs"
  application_name = var.application_name
  vpc_id           = module.vpc.vpc_id
  subnets          = module.subnets.public_subnets
  ecs_task_role_arn = module.iam.ecs_task_role_arn
  ecs_task_execution_role_arn = module.iam.ecs_task_execution_role_arn
}

module "alb" {
  source           = "./modules/alb"
  application_name = var.application_name
  vpc_id           = module.vpc.vpc_id
  subnets          = module.subnets.public_subnets
  security_groups  = [module.security_groups.alb_sg_id]
}

module "vector_ecr" {
  source           = "./modules/ecr"
  repository_name  = var.vector_ecr_name
  environment      = var.environment
  region           = var.region
}

module "elasticsearch_ecr" {
  source           = "./modules/ecr"
  repository_name  = var.elasticsearch_ecr_name
  environment      = var.environment
  region           = var.region
}
