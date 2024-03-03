resource "aws_default_route_table" "main" {
  default_route_table_id = aws_vpc.main.default_route_table_id

  # 空配列を指定した場合も、
  # VPC内への送信を可能にする以下の通信ルートは、デフォルトで作成される
  # (terraformで管理できないルートのため、記載するとエラーになる)
  # route {
  #   cidr_block = var.vpc_cidr
  #   gateway_id = "local"
  # }
  route = []

  tags = {
    Name = "${var.env_name}-default"
  }
}
