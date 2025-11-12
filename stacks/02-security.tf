module "iam" {
  source = "../modules/security/iam"
  project_name = var.project_name
  common_tags = var.common_tags
}

module "sg" {
  source = "../modules/security/security-group"
  project_name = var.project_name
  common_tags = var.common_tags
  vpc_id = module.vpc.vpc_id
}