module "stack" {
  source = "../../stacks"

  region = var.region

  project_name = var.project_name
  common_tags  = var.common_tags

  availability_zones = var.availability_zones
  vpc_cidr           = var.vpc_cidr
  pub_sub_cidr       = var.pub_sub_cidr
  pri_sub_cidr       = var.pri_sub_cidr
  multi_nat          = var.multi_nat

  # 단독 DR 환경
  enable_dr_tokyo         = var.enable_dr_tokyo
  create_route53_failover = var.create_route53_failover
}
