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
