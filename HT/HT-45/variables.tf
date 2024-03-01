variable "vpc_id" {
  description = "This is ID of my VPC"
  type        = string
}

variable "ssh_key" {
  default = "My ssh key for access to EC2"
}

variable "is_public" {
  default = true
}

locals {
  tags = {
    "Name" : "bukhenko-ec2"
    "Owner" : "Olexandr Bukhenko"
    "HT" : "45"
    "vpc" : var.vpc_id
  }
}
