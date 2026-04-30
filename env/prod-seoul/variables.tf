variable "region" {
  type    = string
  default = "ap-northeast-2"
}

variable "project_name" {
  type    = string
  default = "olivesafety-prod"
}

variable "common_tags" {
  type = map(string)
  default = {
    Environment = "prod"
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
  default = true
}

variable "enable_dr_tokyo" {
  type    = bool
  default = true
}

variable "dr_region" {
  type    = string
  default = "ap-northeast-1"
}

variable "dr_vpc_cidr" {
  type = string
}

variable "dr_availability_zones" {
  type = list(string)
}

variable "dr_pub_sub_cidr" {
  type = list(string)
}

variable "dr_pri_sub_cidr" {
  type = list(string)
}

variable "dr_multi_nat" {
  type    = bool
  default = false
}

variable "create_route53_failover" {
  type    = bool
  default = false
}

variable "hosted_zone_id" {
  type    = string
  default = ""
}

variable "service_fqdn" {
  type    = string
  default = ""
}

variable "primary_fqdn" {
  type    = string
  default = ""
}

variable "primary_lb_dns_name" {
  type    = string
  default = ""
}

variable "primary_lb_zone_id" {
  type    = string
  default = ""
}

variable "secondary_lb_dns_name" {
  type    = string
  default = ""
}

variable "secondary_lb_zone_id" {
  type    = string
  default = ""
}
