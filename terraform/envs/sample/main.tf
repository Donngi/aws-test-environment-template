module "network" {
  source = "../../modules/network"

  env_name = "sample"
  vpc_cidr = "10.0.3.0/24"
}
