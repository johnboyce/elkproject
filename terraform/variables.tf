variable "aws_region" {
  description = "AWS region to deploy resources"
  type        = string
  default     = "us-east-1"
}

variable "application_name" {
  description = "Name of the application"
  type        = string
  default     = "elkproject"
}

variable "vector_ecr_name" {
  description = "The name of the ECR repository for the Vector service"
  type        = string
  default     = "vector"
}

variable "elasticsearch_ecr_name" {
  description = "The name of the ECR repository for the Elasticsearch service"
  type        = string
  default     = "elasticsearch"
}

variable "environment" {
  description = "The environment for tagging and resource organization"
  type        = string
  default     = "production"
}

variable "region" {
  description = "AWS region to deploy resources"
  type        = string
  default     = "us-east-1"
}