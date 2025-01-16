variable "quarkus_image" {
  description = "The ECR URL of the Quarkus application image"
  type        = string
}

variable "vector_image" {
  description = "The ECR URL of the Vector image"
  type        = string
}

variable "execution_role_arn" {
  description = "The ARN of the task execution role"
  type        = string
}

variable "task_role_arn" {
  description = "The ARN of the task role"
  type        = string
}

variable "environment" {
  description = "The environment (e.g., dev, prod)"
  type        = string
}

variable "project_name" {
  description = "The name of the project"
  type        = string
}

