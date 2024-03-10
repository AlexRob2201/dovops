resource "aws_instance" "aws_instance" {
  ami                         = var.ami
  instance_type               = var.instance_type
  key_name                    = var.key_name
  user_data                   = var.user_data
  associate_public_ip_address = var.is_public
  security_groups             = var.security_groups
  subnet_id                   = data.aws_subnets.subnets.ids[0]
  tags                        = merge(local.tags, { Name = "${var.name}-ec2" })
}
data "aws_subnets" "subnets" {
  filter {
    name   = "vpc-id"
    values = [var.vpc_id]
  }
}


