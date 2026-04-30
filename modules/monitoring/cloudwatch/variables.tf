variable "project_name" {
  type = string
}

variable "common_tags" {
  type    = map(string)
  default = {}
}

variable "log_group_name" {
  type = string
}

variable "retention_in_days" {
  type    = number
  default = 30
}

variable "alarm_name" {
  type = string
}

variable "sns_topic_arn" {
  type = string
}
