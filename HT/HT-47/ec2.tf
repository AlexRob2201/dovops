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

data "aws_subnets" "subnets" {
  filter {
    name   = "vpc-id"
    values = [var.vpc_id]
  }
}

resource "aws_instance" "instances" {
  for_each = var.instances

  ami                         = data.aws_ami.ubuntu.id
  subnet_id                   = data.aws_subnets.subnets.ids[0]
  instance_type               = each.value.type
  key_name                    = aws_key_pair.ssh_key.key_name
  associate_public_ip_address = var.is_public
  security_groups             = [aws_security_group.some_sg[each.key].id]
  user_data                   = local.userdata

  root_block_device {
    volume_size = each.value.disk
  }
  tags = {
    Name : each.key
  }
}

resource "tls_private_key" "ssh_key" {
  algorithm = "RSA"
  rsa_bits  = 4096
}

resource "aws_key_pair" "ssh_key" {
  key_name   = "${var.name}-key"
  public_key = tls_private_key.ssh_key.public_key_openssh
}

resource "local_file" "ssh_key" {
  content  = tls_private_key.ssh_key.private_key_pem
  filename = "ssh_key"
}


