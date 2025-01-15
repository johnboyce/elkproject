variable "application_name" {
  description = "The name of the application"
  type        = string
}

variable "vpc_id" {
  description = "The ID of the VPC"
  type        = string
}

variable "subnets" {
  description = "The public subnets for the ALB"
  type        = list(string)
}

variable "security_groups" {
  description = "The security groups for the ALB"
  type        = list(string)
}
