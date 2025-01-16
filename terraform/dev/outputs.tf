output "ecs_task_role_arn" {
  description = "The ARN of the ECS task role in dev"
  value       = module.iam.ecs_task_role_arn
}

output "ecs_execution_role_arn" {
  description = "The ARN of the ECS execution role in dev"
  value       = module.iam.ecs_execution_role_arn
}

output "ecs_cluster_name" {
  description = "The ID of the ECS cluster in dev"
  value       = module.ecs_cluster.cluster_name
}

output "vpc_id" {
  description = "The ID of the VPC in dev"
  value       = module.vpc.vpc_id
}

output "alb_dns_name" {
  description = "The DNS name of the ALB in dev"
  value       = module.alb.alb_dns_name
}
