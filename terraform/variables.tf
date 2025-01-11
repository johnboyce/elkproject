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
