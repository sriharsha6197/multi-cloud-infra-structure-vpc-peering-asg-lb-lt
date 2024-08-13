module "vpc" {
  source = "./modules/vpc"
  vpc_cidr = var.vpc_cidr
  env = var.env
  public_subnets = var.public_subnets
  public_rt_cidr_block = var.public_rt_cidr_block
  from_port = var.from_port
  to_port = var.to_port
  private_subnets = var.private_subnets
  public_lb_azs = var.public_lb_azs
  private_lb_azs = var.private_lb_azs
}
module "alb" {
  source = "./modules/lb"
  for_each = var.alb_type_internal
  alb_type = each.value
  internal = each.key
  vpc_id = module.vpc.vpc_ID
  env = var.env
  lb_public_cidr_block = var.public_rt_cidr_block
  SUBNETS = var.alb_type == "public" ? module.vpc.PUBLIC_SUBNETS : module.vpc.PRIVATE_SUBNETS
  from_port = var.from_port
  to_port = var.to_port
}