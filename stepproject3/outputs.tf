output "vpc_id" {
  value = module.step3_vpc.vpc_id
}

output "private_subnets" {
  description = "List of IDs of private subnets"
  value       = module.step3_vpc.private_subnets
}

output "public_subnets" {
  description = "List of IDs of public subnets"
  value       = module.step3_vpc.public_subnets
}
output "security_group_ids" {
  value = module.step3_sg.security_group_ids
}
output "ec2_public_ip" {
  value = module.step3_ec2[*].public_ip
}
