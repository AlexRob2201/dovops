variable "vpc_id" {
  description = "This is ID of my VPC"
  default     = "vpc-06ae62935ffb33e2b"
}

variable "ssh_key" {
  default = "bukhenko-rsa"
}

variable "is_public" {
  default = true
}

variable "region" {
  default = "eu-central-1"
}

variable "name" {
  description = "Global name prefix"
  default = "bukhenko"
}


locals {
  tags = {
    "Name" : "bukhenko-ec2"
    "Owner" : "Olexandr Bukhenko"
    "HT" : "46"
  }
}
