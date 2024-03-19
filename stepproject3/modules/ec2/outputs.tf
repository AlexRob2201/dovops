output "id" {
  description = "The ID of the instance"
  value = aws_instance.this[0].id
}
output "public_ip" {
  description = "The public IP address assigned to the instance, if applicable. NOTE: If you are using an aws_eip with your instance, you should refer to the EIP's address directly and not use `public_ip` as this field will change after the EIP is attached"
  value = aws_instance.this[0].public_ip
}

output "private_ip" {
  description = "The private IP address assigned to the instance"
  value = aws_instance.this[0].private_ip
}
output "tags_all" {
  description = "A map of tags assigned to the resource, including those inherited from the provider default_tags configuration block"
  value = aws_instance.this[0].tags_all
}
output "ami" {
  description = "AMI ID that was used to create the instance"
  value = aws_instance.this[0].ami
}

output "availability_zone" {
  description = "The availability zone of the created instance"
  value = aws_instance.this[0].availability_zone
}