module "vpc" {
  source = "../modules/network/vpc"
  project_name = var.project_name
  common_tags = var.common_tags
  vpc_cidr = var.vpc_cidr
}

module "subnets" {
  source = "../modules/network/subnets"
  project_name = var.project_name
  common_tags = var.common_tags
  
  vpc_id = module.vpc.vpc_id
  availability_zones = var.availability_zones
  pub_sub_cidr = var.pub_sub_cidr
  pri_sub_cidr = var.pri_sub_cidr
}

module "igw_nat" {
  source = "../modules/network/igw-nat"
  project_name = var.project_name
  common_tags = var.common_tags

  vpc_id = module.vpc.vpc_id
  pub_sub_ids = module.subnets.public_subnets
  pri_sub_ids = module.subnets.private_subnets
  multi_nat = var.multi_nat
}