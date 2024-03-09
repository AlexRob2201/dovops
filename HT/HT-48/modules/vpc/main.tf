resource "aws_vpc" "main" {
  cidr_block = var.vpc_main_cidr_block
  tags       = local.tags
}


################################################################################
# PUBLIC SUBNET
################################################################################
resource "aws_subnet" "public_subnet" {
  vpc_id            = aws_vpc.main.id
  cidr_block        = var.vpc_public_subnet
  tags              = local.tags
  availability_zone = "eu-central-1a"
}
resource "aws_internet_gateway" "gw" {
  
  vpc_id = aws_vpc.main.id
  tags   = local.tags

}

resource "aws_route_table" "public_subnet" {
  vpc_id = aws_vpc.main.id

  route {
    cidr_block = var.nat_gateway_destination_cidr_public_block
    gateway_id = aws_internet_gateway.gw.id
  }
  tags = local.tags
}

resource "aws_route_table_association" "public_subnet" {
  subnet_id      = aws_subnet.public_subnet.id
  route_table_id = aws_route_table.public_subnet.id
}

################################################################################
# PRIVATE SUBNET
################################################################################
resource "aws_subnet" "private_subnet" {
  vpc_id            = aws_vpc.main.id
  cidr_block        = var.vpc_private_subnet
  tags              = local.tags
  availability_zone = "eu-central-1a"
}
resource "aws_route_table" "private_subnet" {
  vpc_id = aws_vpc.main.id

  route {
    cidr_block = var.vpc_main_cidr_block
    gateway_id = "local"
  }
}
resource "aws_route_table_association" "private_subnet" {
  subnet_id      = aws_subnet.private_subnet.id
  route_table_id = aws_route_table.private_subnet.id
}
