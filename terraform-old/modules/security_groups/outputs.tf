output "alb_sg_id" {
  value = aws_security_group.alb.id
}

output "ecs_tasks_sg_id" {
  value = aws_security_group.ecs_tasks.id
}

output "private_resources_sg_id" {
  value = aws_security_group.private_resources.id
}
