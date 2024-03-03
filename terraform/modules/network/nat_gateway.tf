# 動作検証用の環境のため、NAT Gatewayは1つのsubnetにのみ配置
resource "aws_nat_gateway" "main" {
  count = var.need_nat_gateway ? 1 : 0

  allocation_id = aws_eip.nat_gateway.id
  subnet_id     = aws_subnet.public[0].id

  tags = {
    Name = "nat-${aws_subnet.public[0].tags["Name"]}"
  }

  depends_on = [aws_internet_gateway.main]
}

resource "aws_eip" "nat_gateway" {
  domain = "vpc"
}
