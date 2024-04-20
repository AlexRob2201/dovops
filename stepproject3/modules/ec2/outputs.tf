output "public_ip" {
  description = "The public IP address assigned to the instance, if applicable. NOTE: If you are using an aws_eip with your instance, you should refer to the EIP's address directly and not use `public_ip` as this field will change after the EIP is attached"
  value       = aws_instance.this.public_ip
}
output "tags" {
  value = aws_instance.this.tags_all
}
output "ec2_id" {
  value = aws_instance.this.id
}