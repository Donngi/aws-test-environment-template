resource "aws_nat_gateway" "main" {
  count = var.need_nat_gateway ? length(aws_subnet.public) : 0

  allocation_id = aws_eip.nat_gateway[count.index].id
  subnet_id     = aws_subnet.public[count.index].id

  tags = {
    Name = "nat-${aws_subnet.public[count.index].tags["Name"]}"
  }

  depends_on = [aws_internet_gateway.main]
}

resource "aws_eip" "nat_gateway" {
  count = var.need_nat_gateway ? length(aws_subnet.public) : 0

  domain = "vpc"
}
