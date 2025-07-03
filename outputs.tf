# Salidas para mostrar la IP pública del ECS
output "ecs_service_url" {
  description = "URL pública del Load Balancer que expone el servicio ECS"
  value       = "http://${module.alb.alb_dns_name}"
}

output "ecs_service_security_group_id" {
  description = "ID del Security Group usado por el servicio ECS"
  value       = module.security_groups.ecs_security_group_id
}

output "alb_security_group_id" {
  description = "ID del Security Group usado por el ALB"
  value       = module.security_groups.alb_security_group_id
}

output "ecs_cluster_arn" {
  description = "ARN del cluster ECS"
  value       = module.ecs.ecs_cluster_arn
}

# Salida para mostrar la URL Publica del API GW
output "api_gateway_url" {
  description = "Public endpoint of the API Gateway"
  value       = module.api_gw.api_gateway_endpoint
}

# Salida para mostrar la IP pública de la instancia
# output "public_ip" {
#   description = "La IP pública de la instancia EC2"
#   value       = module.ec2.public_ip
# }