variable "ami" {
  description = "ID of AMI to use for the instance"
  type        = string
  default     = "ami-04dfd853d88e818e8"
}
variable "instance_type" {
  description = "The type of instance to start"
  type        = string
  default     = "t2.nano"
}
variable "key_name" {
  description = "Key name of the Key Pair to use for the instance; which can be managed using the `aws_key_pair` resource"
  type        = string
  default     = null
}
variable "user_data" {
  description = "The user data to provide when launching the instance. Do not pass gzip-compressed data via this argument; see user_data_base64 instead"
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
  type = string
  default = null
}
variable "region" {
  description = "Choose default region for VPC"
  default = "eu-central-1"
}
variable "name" {
  description = "Some name of ec2"
}
variable "vpc_id" {
  description = "Assing subnet ID"
  type        = string
  default     = "vpc-06ae62935ffb33e2b"
}
variable "tags" {
}
locals {
  tags = merge(var.tags, { Module = "ec2" })
}
