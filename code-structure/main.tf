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

module "alb" {
  source = "./modules/lb"
  env = var.env
  for_each = var.alb_type_internal
  alb_type = each.value
  internal = each.key
  public_subnets = module.vpc.public_subnets
  vpc_id = module.vpc.vpc_CIDR.id
  lb_cidr_block = module.vpc.pb_rt_cidr_block
  from_port = var.from_port
  to_port = var.to_port
}