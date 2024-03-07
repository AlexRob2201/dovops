output "ec2_private_ip" {
  value = aws_instance.private_ec2.private_ip
}
output "ec2_public_ip" {
  value = aws_instance.public_ec2.public_ip
}
output "ssh_key_pair" {
  value = aws_instance.public_ec2.key_name
}
output "vpc_id" {
  value = aws_vpc.main_vpc.id
}

