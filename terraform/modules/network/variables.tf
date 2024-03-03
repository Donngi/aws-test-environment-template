variable "env_name" {
  type        = string
  description = "環境の通称名"
}

variable "vpc_cidr" {
  type        = string
  description = "VPCのCIDR Block"
}

variable "need_nat_gateway" {
  type        = bool
  description = "NAT Gatewayをプロビジョニングするかどうか"
}

variable "required_interface_vpc_endpoints" {
  type        = list(string)
  description = "作成したいinterface vpc endpoint。gateway型のS3, DynamoDBのvpc endpointはデフォルトで作成されます。"
}
