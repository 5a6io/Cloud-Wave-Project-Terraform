########################################
# DR(도쿄) 네트워크 베이스라인
########################################
module "dr_vpc" {
  count = var.enable_dr_tokyo ? 1 : 0

  source = "../modules/network/vpc"
  providers = {
    aws = aws.tokyo
  }

  project_name = "${var.project_name}-dr"
  common_tags = merge(var.common_tags, {
    Role   = "dr"
    Region = var.dr_region
  })
  vpc_cidr = var.dr_vpc_cidr
}

module "dr_subnets" {
  count = var.enable_dr_tokyo ? 1 : 0

  source = "../modules/network/subnets"
  providers = {
    aws = aws.tokyo
  }

  project_name = "${var.project_name}-dr"
  common_tags = merge(var.common_tags, {
    Role   = "dr"
    Region = var.dr_region
  })
  vpc_id             = module.dr_vpc[0].vpc_id
  availability_zones = var.dr_availability_zones
  pub_sub_cidr       = var.dr_pub_sub_cidr
  pri_sub_cidr       = var.dr_pri_sub_cidr
}

module "dr_igw_nat" {
  count = var.enable_dr_tokyo ? 1 : 0

  source = "../modules/network/igw-nat"
  providers = {
    aws = aws.tokyo
  }

  project_name = "${var.project_name}-dr"
  common_tags = merge(var.common_tags, {
    Role   = "dr"
    Region = var.dr_region
  })

  vpc_id      = module.dr_vpc[0].vpc_id
  pub_sub_ids = module.dr_subnets[0].public_subnets
  pri_sub_ids = module.dr_subnets[0].private_subnets
  multi_nat   = var.dr_multi_nat
}
