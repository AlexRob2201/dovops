resource "aws_instance" "aws_instance" {
  ami                         = var.ami
  instance_type               = var.instance_type
  key_name                    = var.key_name
  user_data                   = var.user_data
  associate_public_ip_address = var.is_public
  security_groups             = var.security_groups
  subnet_id                   = var.subnet_id
}
