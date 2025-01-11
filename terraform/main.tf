terraform {
  backend "s3" {
    bucket         = "elkproject-terraform-state"
    key            = "global/s3/terraform.tfstate"
    region         = "us-east-1"
    encrypt        = true
  }
}

provider "aws" {
  region = var.aws_region
}

# VPC Module
module "vpc" {
  source = "./modules/vpc"
  application_name = var.application_name
}

# S3 Module
module "s3" {
  source = "./modules/s3"
  application_name = var.application_name
}
