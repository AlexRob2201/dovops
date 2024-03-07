data "aws_ami" "ubuntu" {
  most_recent = true

  filter {
    name   = "name"
    values = ["ubuntu/images/hvm-ssd/ubuntu-jammy-22.04-amd64-server-*"]
  }

  filter {
    name   = "virtualization-type"
    values = ["hvm"]
  }

  owners = ["099720109477"] # Canonical
}

resource "aws_instance" "public_ec2" {
  ami                         = data.aws_ami.ubuntu.id
  instance_type               = "t2.micro"
  subnet_id                   = aws_subnet.public_subnet.id
  tags                        = local.tags
  key_name                    = var.ssh_key
  associate_public_ip_address = var.is_public
  security_groups = [aws_security_group.some_sg.id]
}

resource "aws_instance" "private_ec2" {
  ami           = data.aws_ami.ubuntu.id
  instance_type = "t2.micro"
  subnet_id     = aws_subnet.private_subnet.id
  tags          = local.tags
  key_name      = var.ssh_key
  security_groups = [aws_security_group.some_sg.id]

  vpc_security_group_ids = [aws_security_group.some_sg.id]
}
