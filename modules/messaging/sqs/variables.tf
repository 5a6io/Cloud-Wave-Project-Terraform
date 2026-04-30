variable "project_name" {
  type = string
}

variable "common_tags" {
  type    = map(string)
  default = {}
}

variable "queue_name" {
  type = string
}

variable "create_dlq" {
  type    = bool
  default = true
}

variable "visibility_timeout_seconds" {
  type    = number
  default = 30
}
