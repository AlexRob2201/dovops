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


locals {
  tags = {

    "Owner" : "Olexandr Bukhenko"
    "HT" : "47"
  }
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
      "ssh_port" = 23
    }
  }
}
