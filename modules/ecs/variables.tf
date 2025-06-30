variable "vpc_id" {
  type = string
}

variable "subnet_ids" {
  type = list(string)
}

variable "security_groups" {
    type = list(string)
}

variable "alb_target_group_arn" {
    type = string
}
