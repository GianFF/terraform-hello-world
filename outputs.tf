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
