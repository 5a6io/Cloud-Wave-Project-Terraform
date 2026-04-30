variable "project_name" {
  type = string
}

variable "common_tags" {
  type    = map(string)
  default = {}
}

variable "bucket_name" {
  type        = string
  description = "정적 웹/아티팩트 저장용 S3 버킷 이름"
}

variable "versioning_enabled" {
  type    = bool
  default = true
}

variable "force_destroy" {
  type    = bool
  default = false
}
