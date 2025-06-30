variable "vpc_id" {
  type = string
}

variable "security_groups" {
  type = list(string)
}

variable "subnet_ids" {
  type = list(string)
}