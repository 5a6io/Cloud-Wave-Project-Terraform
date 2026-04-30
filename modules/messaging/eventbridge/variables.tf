variable "project_name" {
  type = string
}

variable "common_tags" {
  type    = map(string)
  default = {}
}

variable "bus_name" {
  type = string
}

variable "rule_name" {
  type = string
}

variable "event_pattern" {
  type = string
}

variable "target_arn" {
  type = string
}
