variable "cidr_block" {
  description = "CIDR block for the VPC"
  type        = string
}
variable "public_subnets" {
  description = "Map of public subnet CIDRs to their availability zones"
  type        = map(string)
}

variable "private_subnets" {
  description = "Map of private subnet CIDRs to their availability zones"
  type        = map(string)
}

variable "project_name" {
  description = "Name of the project"
  type        = string
}

variable "environment" {
  description = "Environment (e.g., dev, prod)"
  type        = string
}

