variable "key_name" {
  description = "Key name of the Key Pair to use for the instance; which can be managed using the `aws_key_pair` resource"
  type        = string
  default     = null
}
variable "is_public" {
  description = "Use to assign a public IP address"
  type        = bool
  default     = true
}
variable "security_groups" {
  description = "A list of security group IDs to associate with"
  type        = list(string)
  default     = null
}
variable "subnet_id" {
  description = "Assing subnet ID"
  type        = string
  default     = null
}
variable "tags" {
}
variable "name" {
  description = "Global name prefix"
  default     = "bukhenko"
}
variable "user_data" {
  default = ""
}
locals {
  tags = merge(var.tags, { Module = "ec2" })

  userdata = var.user_data != "" ? var.user_data : templatefile("${path.module}/userdata.tpl", {
    ssh_listen_port = 22
    hostname        = var.name
  })
}