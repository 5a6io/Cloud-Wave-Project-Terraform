variable "region" {
  type    = string
  default = "ap-northeast-1"
}

variable "project_name" {
  type    = string
  default = "olivesafety-dr"
}

variable "common_tags" {
  type = map(string)
  default = {
    Environment = "dr"
    ManagedBy   = "terraform"
    Service     = "olivesafety"
  }
}

variable "availability_zones" {
  type = list(string)
}

variable "vpc_cidr" {
  type = string
}

variable "pub_sub_cidr" {
  type = list(string)
}

variable "pri_sub_cidr" {
  type = list(string)
}

variable "multi_nat" {
  type    = bool
  default = false
}

variable "enable_dr_tokyo" {
  type    = bool
  default = false
}

variable "create_route53_failover" {
  type    = bool
  default = false
}
