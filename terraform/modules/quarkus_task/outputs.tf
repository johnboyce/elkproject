// Add output for tekdef arn
output "arn" {
  value = aws_ecs_task_definition.this.arn
}