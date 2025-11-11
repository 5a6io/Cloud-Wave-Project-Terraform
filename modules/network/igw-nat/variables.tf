variable "project_name" {
  type = string
}

variable "common_tags" {
  type = map(string)
  default = {}
}

variable "vpc_id" {
  type = string
}

variable "pub_sub_ids" {
  type = list(string)
}

variable "pri_sub_ids" {
  type = list(string)
}

variable "multi_nat" {
  type = bool
}