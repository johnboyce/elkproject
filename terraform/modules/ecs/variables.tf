variable "application_name" {
  description = "The name of the application"
  type        = string
}

variable "vpc_id" {
  description = "The ID of the VPC"
  type        = string
}

variable "subnets" {
  description = "The list of subnets for ECS services"
  type        = list(string)
}

variable "ecs_task_role_arn" {
  description = "The IAM role for ECS tasks"
  type        = string
}

variable "ecs_task_execution_role_arn" {
  description = "The IAM execution role for ECS tasks"
  type        = string
}
