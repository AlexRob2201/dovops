output "ec2_private_ip" {
  value = aws_instance.test.private_ip
}
output "ec2_public_ip" {
  value = aws_instance.test.public_ip
}
output "ssh_key_pair" {
  value = aws_instance.test.key_name
}
