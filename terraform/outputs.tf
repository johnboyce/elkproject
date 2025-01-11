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
