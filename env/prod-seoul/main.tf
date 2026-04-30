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

  # DR (Tokyo)
  enable_dr_tokyo       = var.enable_dr_tokyo
  dr_region             = var.dr_region
  dr_vpc_cidr           = var.dr_vpc_cidr
  dr_availability_zones = var.dr_availability_zones
  dr_pub_sub_cidr       = var.dr_pub_sub_cidr
  dr_pri_sub_cidr       = var.dr_pri_sub_cidr
  dr_multi_nat          = var.dr_multi_nat

  # DNS Failover (옵션)
  create_route53_failover = var.create_route53_failover
  hosted_zone_id          = var.hosted_zone_id
  service_fqdn            = var.service_fqdn
  primary_fqdn            = var.primary_fqdn
  primary_lb_dns_name     = var.primary_lb_dns_name
  primary_lb_zone_id      = var.primary_lb_zone_id
  secondary_lb_dns_name   = var.secondary_lb_dns_name
  secondary_lb_zone_id    = var.secondary_lb_zone_id
}
