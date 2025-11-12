variable "project_name" {
  type = string
}

variable "common_tags" {
  type = map(string)
  default = {}
}

variable "cloudfront_arn" {
  type = string
}

variable "waf_log_group_arn" {
  type = string
}