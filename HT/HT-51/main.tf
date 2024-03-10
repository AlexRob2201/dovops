provider "aws" {
  region  = "eu-central-1"
  profile = "mfa"
}



module "ec2" {
  count = 2
  source   = "./ec2"
  name = "Bukhenko-${count.index}"
  tags = local.tags
  key_name = aws_key_pair.ssh_key.key_name
}

resource "local_file" "ansible_inventory" {
  filename = "./inventory"
  content  = <<-EOT
[ec2]
${join("\n", [for ec2 in module.ec2 : "${ec2.tags.Name} ansible_host=${ec2.public_ip} ansible_user=ubuntu ansible_ssh_private_key_file=./ssh_key"])}
  EOT
}

resource "tls_private_key" "ssh_key" {
  algorithm = "RSA"
  rsa_bits  = 4096
}

resource "aws_key_pair" "ssh_key" {
  key_name   = "bukhenko-key"
  public_key = tls_private_key.ssh_key.public_key_openssh
}

resource "local_file" "ssh_key" {
  content  = tls_private_key.ssh_key.private_key_pem
  filename = "ssh_key"
}