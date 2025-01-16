output "quarkus_service_name" {
  description = "The name of the Quarkus ECS service"
  value       = aws_ecs_service.quarkus_service.name
}

output "quarkus_service_id" {
  description = "The ARN of the Quarkus ECS service"
  value       = aws_ecs_service.quarkus_service.id
}
