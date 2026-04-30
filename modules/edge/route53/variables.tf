variable "zone_name" {
  type        = string
  description = "관리할 퍼블릭 호스티드 존 이름"
}

variable "record_name" {
  type        = string
  description = "생성할 레코드 이름 (예: app.example.com)"
}

variable "cloudfront_domain_name" {
  type = string
}

variable "cloudfront_hosted_zone_id" {
  type    = string
  default = "Z2FDTNDATAQYW2"
}

variable "common_tags" {
  type    = map(string)
  default = {}
}
