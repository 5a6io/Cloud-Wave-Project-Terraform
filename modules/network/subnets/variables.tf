variable "project_name" {
  type = string
  description = "프로젝트 이름"
}

variable "common_tags" {
  type = map(string)
  default = {}
}

variable "vpc_id" {
  type = string
}

variable "availability_zones" {
  type = list(string)
}

variable "pub_sub_cidr" {
  type = list(string)
}

variable "pri_sub_cidr" {
  type = list(string)
}
