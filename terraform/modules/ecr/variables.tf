variable "repository_name" {
  description = "The name of the ECR repository"
  type        = string
}

variable "environment" {
  description = "The environment for tagging and resource organization"
  type        = string
}

variable "region" {
  description = "AWS region for the repository"
  type        = string
}
