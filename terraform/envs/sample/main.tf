module "network" {
  source = "../../modules/network"

  vpc_cidr = "10.0.3.0/24"
}
