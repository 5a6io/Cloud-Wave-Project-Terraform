variable "project_name" {
  type = string
}

variable "common_tags" {
  type    = map(string)
  default = {}
}

variable "topic_name" {
  type = string
}

variable "sqs_endpoint_arn" {
  type    = string
  default = null
}
