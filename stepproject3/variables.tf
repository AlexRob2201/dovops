variable "name" {
  default = "bukhenko"
}

variable "instances" {
  default = {
    "step3-instance-1" = {
      "type"     = "t2.nano"
      "ssh_port" = 22
    }
    "step3-instance-2" = {
      "type"     = "t2.micro"
      "ssh_port" = 22
    }
    "step3-instance-3" = {
      "type"     = "t2.micro"
      "ssh_port" = 22
    }
  }
}
locals {
  tags = {
    "Owner" : "Olexanr Bukhenko"
    "Managed by" : "terraform"
    "Purpose" : "Step3"
  }
}

variable "create_ec2" {
  default = false
}

variable "alb_domain" {
  default = "grafana-alex.watashinoheyadesu.pp.ua"
}

variable "zone_id" {
  default = "Z07116929175HMIOIA0C"
}
