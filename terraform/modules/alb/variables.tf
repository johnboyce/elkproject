variable "project_name" {
  description = "The name of the project"
  type        = string
}

variable "environment" {
  description = "The environment (e.g., dev, prod)"
  type        = string
}

variable "security_group_id" {
  description = "The security group for the ALB"
  type        = string
}

variable "subnet_ids" {
  description = "The subnets for the ALB"
  type        = list(string)
}

