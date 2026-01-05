provider "aws" {
  region = var.region
}

module "network" {
  source         = "../../modules/network"
  env            = var.env
  vpc_cidr       = var.vpc_cidr
  public_subnets = var.public_subnets
  azs            = var.azs
}

module "alb" {
  source     = "../../modules/alb"
  env        = var.env
  vpc_id     = module.network.vpc_id
  subnet_ids = module.network.public_subnet_ids
}

module "compute" {
  source           = "../../modules/compute"
  env              = var.env
  vpc_id           = module.network.vpc_id
  subnet_ids       = module.network.public_subnet_ids
  alb_sg_id        = module.alb.alb_sg_id
  target_group_arn = module.alb.target_group_arn
  instance_type    = var.instance_type
}
