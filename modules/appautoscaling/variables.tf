variable "service_namespace" {
  type    = string
  default = "ecs"
}

variable "resource_id" {
  type        = string
  description = "Resource ID: service/cluster-name/service-name"
}

variable "min_capacity" {
  type    = number
  default = 1
}

variable "max_capacity" {
  type    = number
  default = 5
}

variable "scale_out_threshold" {
  type    = number
  default = 50
}

variable "scale_in_threshold" {
  type    = number
  default = 30
}
