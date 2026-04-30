variable "region" {
  type = string
}

variable "dr_region" {
  type        = string
  default     = "ap-northeast-1"
  description = "DR 리전 (도쿄)"
}

variable "project_name" {
  type = string
}

variable "availability_zones" {
  type = list(string)
}

variable "common_tags" {
  type    = map(string)
  default = {}
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
  type = bool
}

variable "enable_dr_tokyo" {
  type        = bool
  default     = false
  description = "도쿄 DR 스택 활성화 여부"
}

variable "dr_vpc_cidr" {
  type        = string
  description = "도쿄 DR VPC CIDR"
}

variable "dr_availability_zones" {
  type        = list(string)
  description = "도쿄 DR AZ 목록"
}

variable "dr_pub_sub_cidr" {
  type        = list(string)
  description = "도쿄 DR 퍼블릭 서브넷 CIDR"
}

variable "dr_pri_sub_cidr" {
  type        = list(string)
  description = "도쿄 DR 프라이빗 서브넷 CIDR"
}

variable "dr_multi_nat" {
  type        = bool
  default     = false
  description = "도쿄 DR 다중 NAT 사용 여부"
}

variable "create_route53_failover" {
  type        = bool
  default     = false
  description = "Route53 failover 레코드 생성 여부"
}

variable "hosted_zone_id" {
  type        = string
  default     = ""
  description = "Route53 Hosted Zone ID"
}

variable "service_fqdn" {
  type        = string
  default     = ""
  description = "failover 대상 서비스 FQDN"
}

variable "primary_fqdn" {
  type        = string
  default     = ""
  description = "Primary(서울) 헬스체크 대상 FQDN"
}

variable "primary_health_check_path" {
  type        = string
  default     = "/healthz"
  description = "Primary 헬스체크 경로"
}

variable "primary_lb_dns_name" {
  type        = string
  default     = ""
  description = "Primary ALB/NLB DNS 이름"
}

variable "primary_lb_zone_id" {
  type        = string
  default     = ""
  description = "Primary ALB/NLB Hosted Zone ID"
}

variable "secondary_lb_dns_name" {
  type        = string
  default     = ""
  description = "Secondary(도쿄) ALB/NLB DNS 이름"
}

variable "secondary_lb_zone_id" {
  type        = string
  default     = ""
  description = "Secondary(도쿄) ALB/NLB Hosted Zone ID"
}
