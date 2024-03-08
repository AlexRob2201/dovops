resource "aws_security_group" "some_sg" {
  vpc_id = var.vpc_id
  for_each = var.instances

  ingress {
    description = "SSH"
    from_port   = each.value.ssh_port
    to_port     = each.value.ssh_port
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
  tags = {
    Name : each.key
  }
}
