resource "aws_subnet" "public" {
  count = length(data.aws_availability_zones.available.names)

  vpc_id            = aws_vpc.main.id
  availability_zone = data.aws_availability_zones.available.names[count.index]

  # 2024/3時点で、1リージョンあたりの最大AZ数は6のため、3bit=8分割でIPアドレスを効率的に割り振れる
  cidr_block = cidrsubnet(aws_vpc.main.cidr_block, 3, count.index * 2)

  tags = {
    Name = "${var.env_name}-public-${data.aws_availability_zones.available.names[count.index]}"
  }
}
