variable "project_name" {
  type = string
}

variable "common_tags" {
  type    = map(string)
  default = {}
}

variable "aliases" {
  type    = list(string)
  default = []
}

variable "acm_certificate_arn" {
  type        = string
  description = "us-east-1 리전에 발급된 CloudFront용 ACM 인증서 ARN"
}

variable "origin_domain_name" {
  type        = string
  description = "CloudFront 원본 도메인(S3 bucket regional domain or ALB DNS)"
}

variable "origin_id" {
  type    = string
  default = "origin-main"
}

variable "waf_web_acl_id" {
  type    = string
  default = null
}
