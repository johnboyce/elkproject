variable "vpc_id" {
  description = "The ID of the VPC"
  type        = string
}

variable "vpc_cidr" {
  description = "The CIDR block of the VPC"
  type        = string
  default     = "10.0.0.0/16"
}

variable "application_name" {
  description = "The name of the application"
  type        = string
}
