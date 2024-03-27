provider "aws" {
  region  = "eu-central-1"
  profile = "mfa"
}

module "step3_vpc" {
  source = "terraform-aws-modules/vpc/aws"

  name = "bukhenko-vpc-step3"
  cidr = "192.168.0.0/16"

  azs             = ["eu-central-1a", "eu-central-1b", "eu-central-1c"]
  private_subnets = ["192.168.1.0/24"]
  public_subnets  = ["192.168.2.0/24"]

  enable_nat_gateway = true

  tags = {
    Name : "bukhenko-VPC"
    Owner : "Olexandr Bukhenko",
    CreatedBy : "Bukhenko-step3",
    Purpose : "step3"
  }
}

module "step3_sg" {
  source = "./modules/sg"

  vpc_id = module.step3_vpc.vpc_id
  name   = "bukhenko"
  tags = {
    Owner : "Olexandr Bukhenko",
    CreatedBy : "Bukhenko-step3",
    Purpose : "step3"
  }
}

module "step3_ec2" {
  ec2_psc = 3
  source  = "./modules/ec2"

  name            = "bukhenko-step3"
  ami             = "ami-023adaba598e661ac"
  key_name        = aws_key_pair.ssh_key.key_name
  instance_type   = "t2.micro"
  subnet_id       = module.step3_vpc.public_subnets[0]
  security_groups = [module.step3_sg.security_group_ids]
  user_data       = data.template_file.userdata.rendered
  tags = {
    Owner : "Olexandr Bukhenko",
    CreatedBy : "Bukhenko-step3",
    Purpose : "step3"
  }
}

  # userdata = var.user_data != "" ? var.user_data : templatefile("${path.module}/userdata.tpl", {
  #   ssh_listen_port = 22
  #   hostname        = var.name
  # })

data "template_file" "userdata" {
  template = file("${path.module}/userdata.tpl")

  vars = {
    ssh_key_name = aws_key_pair.ssh_key.key_name
    hostname = var.name
    ssh_listen_port = 22
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
  filename = "ssh_key.pem"
}


module "test" {
  source  = "./modules/ec2"

  name            = "bukhenko-test"
  ami             = "ami-023adaba598e661ac"
  key_name        = "bukhenko-rsa"
  instance_type   = "t2.nano"
  subnet_id       = module.step3_vpc.public_subnets[0]
  security_groups = [module.step3_sg.security_group_ids]
  tags = {
    Owner : "Olexandr Bukhenko",
    CreatedBy : "Bukhenko-step3",
    Purpose : "test"
  }
}