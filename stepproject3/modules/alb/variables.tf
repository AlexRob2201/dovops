variable "name" {
}

variable "tags" {
}

variable "zone_id" {
}

variable "alb_domain" {
}

variable "vpc_id" {
}

variable "public_subnets" {
  type = list(string)
}

variable "ec2_ids" {
  type = list(string)
}
