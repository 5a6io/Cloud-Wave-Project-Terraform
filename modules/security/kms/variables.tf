variable "project_name" {
  type = string
}

variable "common_tags" {
  type    = map(string)
  default = {}
}

variable "deletion_window_in_days" {
  type    = number
  default = 30
}
