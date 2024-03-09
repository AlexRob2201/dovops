output "pub_ip" {
  value = module.public_ec2.public_ip
}
output "security_group_ids" {
  value = module.security_group_ec2.security_group_ids
}