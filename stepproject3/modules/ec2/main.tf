################################################################################
# Instance
################################################################################
resource "aws_instance" "this" {
  ################################################################################
  # Require
  ################################################################################
  ami                    = var.ami
  instance_type          = var.instance_type
  subnet_id              = var.subnet_id
  vpc_security_group_ids = var.vpc_security_group_ids
  user_data              = var.user_data
  ################################################################################
  # Other
  ################################################################################
  availability_zone           = var.availability_zone
  key_name                    = var.key_name
  associate_public_ip_address = var.associate_public_ip_address
}
