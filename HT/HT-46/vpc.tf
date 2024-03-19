resource "aws_vpc" "main_vpc" {
  cidr_block           = "10.0.0.0/16"
  instance_tenancy     = "default"
  enable_dns_hostnames = "true"

  tags = {
    Name = "Bukhenko-ht-46"
  }
}
resource "aws_subnet" "public_subnet" {
  vpc_id                  = aws_vpc.main_vpc.id
  cidr_block              = "10.0.1.0/24"
  availability_zone       = "eu-central-1a"
  map_public_ip_on_launch = "true"

  tags = {
    Name = "Bukhenko-ht-46"
  }
}
resource "aws_subnet" "private_subnet" {
  vpc_id            = aws_vpc.main_vpc.id
  cidr_block        = "10.0.2.0/24"
  availability_zone = "eu-central-1a"

  tags = {
    Name = "Bukhenko-ht-46"
  }
}


# resource "aws_vpc" "main_vpc" {
#   cidr_block = "10.0.0.0/16"
# }

# resource "aws_subnet" "public_subnet" {
#   vpc_id                  = aws_vpc.main_vpc.id
#   cidr_block              = "10.0.1.0/24"
#   map_public_ip_on_launch = true

#   tags = {
#     Name : "bukhenko_public_subnet"
#   }
# }

# resource "aws_subnet" "private_subnet" {
#   vpc_id     = aws_vpc.main_vpc.id
#   cidr_block = "10.0.2.0/24"

#   tags = {
#     Name : "bukhenko_private_subnet"
#   }
# }

# resource "aws_internet_gateway" "main_igw" {
#   vpc_id = aws_vpc.main_vpc.id

#   tags = {
#     Name = "Bukhenko-ht-46"
#   }
# }

# resource "aws_route_table" "public_route_table" {
#   vpc_id = aws_vpc.main_vpc.id

#   route {
#     cidr_block = "0.0.0.0/0"
#     gateway_id = aws_internet_gateway.main_igw.id  # ID вашого інтернет-шлюзу
#   }

#   tags = {
#     Name = "PublicRouteTable"
#   }
# }

# resource "aws_route_table_association" "public_subnet_association" {
#   subnet_id      = aws_subnet.public_subnet.id
#   route_table_id = aws_route_table.public_route_table.id
# }

# resource "aws_route_table" "private_route_table" {
#   vpc_id = aws_vpc.main_vpc.id

#   tags = {
#     Name = "PrivateRouteTable"
#   }
# }

# resource "aws_route_table_association" "private_subnet_association" {
#   subnet_id      = aws_subnet.private_subnet.id
#   route_table_id = aws_route_table.private_route_table.id
# }

