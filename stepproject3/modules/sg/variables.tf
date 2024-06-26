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
    "80" = "tcp",
    "3000" = "tcp",
    "9090" = "tcp",
    "9100" = "tcp",
    "9104" = "tcp",
    "9101" = "tcp"
  }
}
variable "egress_rules" {
  description = "List of ingress rules to create by name"
  type        = map(string)
  default = {
    "-1" = "0"
  }
}
variable "tags" {
}
locals {
  tags = merge(var.tags, { Module = "ec2", Name = "${var.name}-sg" })
}
