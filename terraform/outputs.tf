output "vpc_id" {
  value = module.vpc.vpc_id
}

output "public_subnets" {
  value = module.subnets.public_subnets
}

output "private_subnets" {
  value = module.subnets.private_subnets
}

output "alb_sg_id" {
  value = module.security_groups.alb_sg_id
}

output "ecs_tasks_sg_id" {
  value = module.security_groups.ecs_tasks_sg_id
}

output "private_resources_sg_id" {
  value = module.security_groups.private_resources_sg_id
}
output "ecs_cluster_name" {
  value = module.ecs.cluster_name
}

output "ecs_cluster_arn" {
  value = module.ecs.cluster_arn
}

output "alb_arn" {
  value = module.alb.alb_arn
}

output "alb_dns_name" {
  value = module.alb.alb_dns_name
}

output "target_group_arn" {
  value = module.alb.target_group_arn
}

output "vector_ecr_url" {
  description = "The URL of the Vector ECR repository"
  value       = module.vector_ecr.repository_url
}

output "vector_ecr_arn" {
  description = "The ARN of the Vector ECR repository"
  value       = module.vector_ecr.repository_arn
}

output "elasticsearch_ecr_url" {
  description = "The URL of the Elasticsearch ECR repository"
  value       = module.elasticsearch_ecr.repository_url
}

output "elasticsearch_ecr_arn" {
  description = "The ARN of the Elasticsearch ECR repository"
  value       = module.elasticsearch_ecr.repository_arn
}


