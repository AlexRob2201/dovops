provider "aws" {
  region  = "eu-central-1"
  profile = "mfa"
}

module "step3_vpc" {
  source = "terraform-aws-modules/vpc/aws"

  name = "${var.name}-vpc"
  cidr = "192.168.0.0/16"

  azs             = ["eu-central-1a", "eu-central-1b", "eu-central-1c"]
  private_subnets = ["192.168.1.0/24", "192.168.4.0/24"]
  public_subnets  = ["192.168.2.0/24", "192.168.3.0/24"]

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
  name   = "${var.name}-sg"
  tags = {
    Owner : "Olexandr Bukhenko",
    CreatedBy : "Bukhenko-step3",
    Purpose : "step3"
  }
}

module "step3_ec2" {
  for_each        = var.instances
  source          = "./modules/ec2"
  key_name        = aws_key_pair.ssh_key.key_name
  subnet_id       = module.step3_vpc.public_subnets[0]
  security_groups = [module.step3_sg.security_group_ids]
  tags = {
    Name : each.key
    Owner : "Olexandr Bukhenko",
    CreatedBy : "Bukhenko-step3",
    Purpose : "step3"
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

resource "local_file" "ansible_inventory" {
  filename = "./inventory"
  content  = <<-EOT
[ec2]
${join("\n", [for ec2 in module.step3_ec2 : "${ec2.tags.Name} ansible_host=${ec2.public_ip} ansible_user=alex ansible_ssh_private_key_file=./id_rsa"])}
  EOT
}

# resource "null_resource" "run_ansible_playbook" {
#   depends_on = [module.step3_ec2, local_file.ansible_inventory]
#   triggers = {
#     always_run = "${timestamp()}"
#   }
#   provisioner "local-exec" {
#     command = "ansible-playbook main_ansible.yml -i inventory"
#   }
# }


# module "step3_alb" {
#   count          = terraform.workspace == "prod" ? 1 : 0
#   source         = "./modules/alb"
#   name           = "${var.name}"
#   tags           = local.tags
#   zone_id        = var.zone_id
#   alb_domain     = var.alb_domain
#   vpc_id         = module.step3_vpc.vpc_id
#   public_subnets = module.step3_vpc.public_subnets[*]
#   ec2_ids        = [for obj in module.step3_ec2 : obj.ec2_id]
# }