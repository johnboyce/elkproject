variable "region" {
  description = "AWS region for the resources"
  type        = string
}

variable "project_name" {
  description = "Name of the project"
  type        = string
  default     = "elkproject"
}

variable "environment" {
  description = "Environment for the bucket (e.g., dev, prod)"
  type        = string
  default     = "global"
}
