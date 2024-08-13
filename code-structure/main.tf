module "vpc" {
  source = "./modules/vpc"
  vpc_cidr = var.vpc_cidr
  env = var.env
  public_subnets = var.public_subnets
  public_rt_cidr_block = var.public_rt_cidr_block
  from_port = var.from_port
  to_port = var.to_port
  private_subnets = var.private_subnets
}