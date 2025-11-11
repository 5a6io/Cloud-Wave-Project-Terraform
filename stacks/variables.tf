variable "region" {
  type = string
}

variable "project_name" {
  type = string
}

variable "availability_zones" {
  type = list(string)
}

variable "common_tags" {
  type = map(string)
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