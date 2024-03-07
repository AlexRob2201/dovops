resource "aws_internet_gateway" "my_ie" {
  vpc_id = aws_vpc.main_vpc.id

  tags = {
    Name = "Bukhenko-ht-46"
  }
}
