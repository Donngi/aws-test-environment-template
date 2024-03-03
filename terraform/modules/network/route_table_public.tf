resource "aws_route_table" "public" {
  count = length(aws_subnet.public)

  vpc_id = aws_vpc.main.id

  route {
    cidr_block = aws_vpc.main.cidr_block
    gateway_id = "local"
  }

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.main.id
  }

  tags = {
    Name = aws_subnet.public[count.index].tags["Name"]
  }
}

# aws_route_table に直接data resourceで参照した prefix list のルートを記載すると
# InvalidParameterValue: Cannot create or replace a prefix list route targeting a VPC Endpoint.
# が発生した
# Gateway Endpointへのrouteは、aws_vpc_endpoint_route_table_association で行わなくてはならない模様
# https://github.com/hashicorp/terraform-provider-aws/issues/18607
resource "aws_vpc_endpoint_route_table_association" "public_s3" {
  count = length(aws_subnet.public)

  route_table_id  = aws_route_table.public[count.index].id
  vpc_endpoint_id = aws_vpc_endpoint.s3.id
}

resource "aws_vpc_endpoint_route_table_association" "public_dynamodb" {
  count = length(aws_subnet.public)

  route_table_id  = aws_route_table.public[count.index].id
  vpc_endpoint_id = aws_vpc_endpoint.dynamodb.id
}

resource "aws_route_table_association" "public" {
  count = length(aws_subnet.public)

  subnet_id      = aws_subnet.public[count.index].id
  route_table_id = aws_route_table.public[count.index].id
}
