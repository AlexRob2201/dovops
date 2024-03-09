variable "create" {
  description = "Whether to create security group and all rules"
  type        = bool
  default     = true
}
variable "name" {
  description = "Name for SG"
  default = null
}
variable "vpc_id" {
  description = "value"
  type        = string
  default     = null
}
variable "ingress_rules" {
  description = "List of ingress rules to create by name"
  type        = map(string)
  default = {
    "22" = "tcp",
    "80" = "tcp"
  }
}
variable "egress_rules" {
  description = "List of ingress rules to create by name"
  type        = map(string)
  default = {
    "-1" = "0"
  }
}
locals {
  tags = {
    "Name" : "Bukhenko-SG"
    "Owner" : "Olexandr Bukhenko"
  }
}
