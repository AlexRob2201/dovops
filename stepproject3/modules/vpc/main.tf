locals {
  create_public_subnets = local.len_public_subnets > 0
  vpc_id                = try(aws_vpc_ipv4_cidr_block_association.this[0].vpc_id, aws_vpc.this[0].id, "")
}
################################################################################
# VPC
################################################################################
resource "aws_vpc" "this" {
  count                = var.create ? 1 : 0
  cidr_block           = var.cidr
  instance_tenancy     = "default"
  enable_dns_hostnames = true

  tags = local.tags
}
resource "aws_vpc_ipv4_cidr_block_association" "this" {
  count = length(var.secondary_cidr_blocks) > 0 ? length(var.secondary_cidr_blocks) : 0

  vpc_id = aws_vpc.this[count.index].id

  cidr_block = element(var.secondary_cidr_blocks, count.index)
}


################################################################################
# Publiс Subnets
################################################################################
resource "aws_subnet" "public_subnet" {
  count = local.create_public_subnets && (!var.one_nat_gateway_per_az || local.len_public_subnets >= length(var.azs)) ? local.len_public_subnets : 0

  vpc_id                  = aws_vpc.this[0].id
  cidr_block              = element(concat(var.public_subnets, [""]), count.index)
  availability_zone       = length(regexall("^[a-z]{2}-", element(var.azs, count.index))) > 0 ? element(var.azs, count.index) : null
  map_public_ip_on_launch = true

  tags = local.tags
}
resource "aws_route_table" "public" {
  count  = local.create_public_subnets ? 1 : 0
  vpc_id = aws_vpc.this[0].id

  tags = local.tags
}

resource "aws_route_table_association" "public" {
  count = var.create ? local.len_public_subnets : 0

  subnet_id      = element(aws_subnet.public_subnet[*].id, count.index)
  route_table_id = aws_route_table.public[0].id
}

resource "aws_route" "public_internet_gateway" {


  route_table_id         = aws_route_table.public[0].id
  destination_cidr_block = "0.0.0.0/0"
  gateway_id             = aws_internet_gateway.this[0].id

  timeouts {
    create = "5m"
  }
}


################################################################################
# Private subnet
################################################################################
resource "aws_subnet" "private_subnet" {
  count = local.len_private_subnets >= length(var.azs) ? local.len_private_subnets : 0

  vpc_id            = aws_vpc.this[0].id
  cidr_block        = element(concat(var.private_subnets, [""]), count.index)
  availability_zone = length(regexall("^[a-z]{2}-", element(var.azs, count.index))) > 0 ? element(var.azs, count.index) : null

  tags = local.tags
}


################################################################################
# Internet Gateway
################################################################################

resource "aws_internet_gateway" "this" {
  count = var.enable_nat_gateway ? 1 : 0

  vpc_id = aws_vpc.this[0].id

  tags = local.tags
}
