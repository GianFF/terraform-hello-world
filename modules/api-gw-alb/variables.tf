variable "name" {
  type        = string
  description = "API Gateway name"
}

variable "alb_listener_arn" {
  description = "ARN del listener HTTP del ALB que apunta al ECS"
  type        = string
}

variable "name" {
  description = "Nombre de la API Gateway HTTP API"
  type        = string
}

variable "method" {
  description = "Método HTTP para rutear (ejemplo: 'ANY')"
  type        = string
}

variable "path" {
  description = "Ruta a exponer en el API Gateway (ejemplo: '/{proxy+}')"
  type        = string
}

variable "method" {
  type        = string
  default     = "ANY"
  description = "HTTP method for the route"
}

variable "path" {
  type        = string
  default     = "/"
  description = "Route path"
}
