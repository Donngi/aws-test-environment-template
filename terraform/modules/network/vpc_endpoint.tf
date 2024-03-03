# ------------------------------------------------------------
# Gateway endpoints
# ------------------------------------------------------------

resource "aws_vpc_endpoint" "s3" {
  vpc_id            = aws_vpc.main.id
  service_name      = "com.amazonaws.${data.aws_region.current.name}.s3"
  vpc_endpoint_type = "Gateway"

  tags = {
    Environment = "${var.env_name}-s3"
  }
}

resource "aws_vpc_endpoint" "dynamodb" {
  vpc_id            = aws_vpc.main.id
  service_name      = "com.amazonaws.${data.aws_region.current.name}.dynamodb"
  vpc_endpoint_type = "Gateway"

  tags = {
    Environment = "${var.env_name}-dynamodb"
  }
}

# ------------------------------------------------------------
# Interface endpoints
# ------------------------------------------------------------

resource "aws_vpc_endpoint" "ec2" {
  vpc_id            = aws_vpc.main.id
  service_name      = "com.amazonaws.${data.aws_region.current.name}.ec2"
  vpc_endpoint_type = "Interface"

  # 動作検証用の環境のため、冗長性よりもコストを優先し、1つのPrivate subnetにのみ配置
  subnet_ids = [
    aws_subnet.private[0].id,
  ]

  security_group_ids = [
    aws_security_group.vpc_endpoint.id
  ]

  private_dns_enabled = true
}
