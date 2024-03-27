################################################################################
# Instance
################################################################################
resource "aws_instance" "this" {
  count = var.create ? var.ec2_psc : 0

  ami                         = var.ami
  subnet_id                   = var.subnet_id
  instance_type               = var.instance_type
  key_name                    = var.key_name
  associate_public_ip_address = var.is_public
  security_groups             = var.security_groups
  user_data                   = var.userdata
  
  tags = local.tags
}




