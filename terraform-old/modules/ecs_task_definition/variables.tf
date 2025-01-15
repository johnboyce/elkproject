variable "family" {
  description = "The family of the ECS task definition"
  type        = string
}

variable "execution_role_arn" {
  description = "The ARN of the task execution IAM role"
  type        = string
}

variable "task_role_arn" {
  description = "The ARN of the ECS task IAM role"
  type        = string
}

variable "cpu" {
  description = "The amount of CPU units to allocate"
  type        = string
}

variable "memory" {
  description = "The amount of memory (in MiB) to allocate"
  type        = string
}

variable "container_name" {
  description = "The name of the container"
  type        = string
}

variable "image" {
  description = "The container image URI"
  type        = string
}

variable "port_mappings" {
  description = "Port mappings for the container"
  type = list(object({
    containerPort = number
    protocol      = string
  }))
}

variable "log_group" {
  description = "CloudWatch log group name"
  type        = string
}

variable "log_stream_prefix" {
  description = "CloudWatch log stream prefix"
  type        = string
}

variable "aws_region" {
  description = "AWS region to deploy resources"
  type        = string
}