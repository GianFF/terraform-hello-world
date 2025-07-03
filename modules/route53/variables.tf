# Variable para el dominio de prueba en Route 53
variable "domain_name" {
  description = "Dominio custom a exponer en API Gateway y Route 53 (ej: api.tudominio.com)"
  type        = string
}

variable "certificate_arn" {
  description = "ARN del certificado ACM para el dominio custom"
  type        = string
}

variable "api_id" {
  description = "ID del API Gateway HTTP API v2 a asociar al dominio custom"
  type        = string
}