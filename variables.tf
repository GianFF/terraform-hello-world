# Variable para la región de AWS
variable "region" {
  description = "Región de AWS donde se desplegarán los recursos"
  type        = string
  default     = "us-east-1"
}

# Variables para credenciales de AWS
variable "aws_access_key" {
  description = "Access key de AWS"
  type        = string
  sensitive   = true
}

variable "aws_secret_key" {
  description = "Secret key de AWS"
  type        = string
  sensitive   = true
}