module "vpc" {
  source = "./modules/vpc"
}

module "bastion" {
  source        = "./modules/bastion"
  public_subnet = module.vpc.public_subnets[0]
  vpc_id        = module.vpc.vpc_id
}

module "ec2" {
  source = "./modules/ec2"

  private_subnets = module.vpc.private_subnets
  vpc_id          = module.vpc.vpc_id

  alb_sg_id       = module.alb.alb_sg_id
  bastion_sg_id   = module.bastion.bastion_sg_id
  target_group_arn = module.alb.target_group_arn
}

module "alb" {
  source         = "./modules/alb"
  vpc_id         = module.vpc.vpc_id
  public_subnets = module.vpc.public_subnets
}

module "rds" {
  source = "./modules/rds"
}
