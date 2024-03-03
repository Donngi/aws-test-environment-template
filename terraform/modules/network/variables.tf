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
