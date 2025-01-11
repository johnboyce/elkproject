variable "application_name" {
  description = "Name of the application"
  type        = string
}

variable "skip_bucket_creation" {
  description = "Skip bucket creation if it already exists"
  type        = bool
  default     = true
}