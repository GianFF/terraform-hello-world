variable "alb_listener_arn" {
  description = "ARN del listener HTTP del ALB que apunta al ECS"
  type        = string
}

variable "routes" {
  description = "Lista de rutas a exponer en el API Gateway. Cada ruta es un objeto con 'method' y 'path'."
  type = list(object({
    method = string
    path   = string
  }))
  default = [
    // Default route, matches all methods and paths
    { method = "ANY", path = "/{proxy+}" }
  ]
}
