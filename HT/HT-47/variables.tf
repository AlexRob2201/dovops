variable "vpc_id" {
  description = "This is ID of my VPC"
  default     = "vpc-06ae62935ffb33e2b"
}

variable "is_public" {
  default = true
}

variable "region" {
  default = "eu-central-1"
}

variable "name" {
  description = "Global name prefix"
  default     = "bukhenko"
}
variable "user_data" {
  default = ""
}

locals {
  tags = {

    "Owner" : "Olexandr Bukhenko"
    "HT" : "47"
  }

  userdata = var.user_data != "" ? var.user_data : templatefile("${path.module}/userdata.tpl", {
    ssh_listen_port = 22
    hostname        = var.name
  })
}


variable "instances" {
  default = {
    "ec1" = {
      "disk"     = 10
      "type"     = "t2.nano"
      "ssh_port" = 22
    }
    "ec2" = {
      "disk"     = 20
      "type"     = "t2.micro"
      "ssh_port" = 22
    }
  }
}
