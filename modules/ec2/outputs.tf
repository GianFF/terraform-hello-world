output "public_ip" {
  description = "IP publica del servidor web"
  value = aws_instance.web_server.public_ip
}

output "web_server_state" {
  description = "El estado actual del servidor web"
  value       = aws_instance.web_server.instance_state
}

output "security_group_id" {
  description = "El ID del grupo de seguridad"
  value       = aws_security_group.web_server.id
}
