locals {
  tags = {
    "Name" : "Bukhenko-VPC"
    "Owner" : "Olexandr Bukhenko"
  }
}

variable "region" {
  description = "Choose default region for VPC"
  default = "eu-central-1"
}

################################################################################
# VPC
################################################################################
variable "vpc_main_cidr_block" {
  description = "value"
  type = string
  default = "172.20.0.0/16"
}
variable "vpc_private_subnet" {
  description = "value"
  type = string
  default = "172.20.1.0/24"
}
variable "vpc_public_subnet" {
  description = "value"
  type = string
  default = "172.20.2.0/24"
}


################################################################################
# NAT Gateway
################################################################################

variable "enable_nat_gateway" {
  description = "Should be true if you want to provision NAT Gateways for each of your private networks"
  type        = bool
  default     = false
}

variable "nat_gateway_destination_cidr_public_block" {
  description = "Used to pass a custom destination route for private NAT Gateway. If not specified, the default 0.0.0.0/0 is used as a destination route"
  type        = string
  default     = "0.0.0.0/0"
}

variable "create_igw" {
  description = "Controls if an Internet Gateway is created for public subnets and the related routes that connect them"
  type        = bool
  default     = true
}



