output "vpc_id" {
  value = module.vpc.vpc_id
}

output "s3_bucket_name" {
  value = module.s3.bucket_name
}

output "public_subnets" {
  value = module.subnets.public_subnets
}

output "private_subnets" {
  value = module.subnets.private_subnets
}
