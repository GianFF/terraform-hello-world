output "test_zone_id" {
  description = "ID de la zona hospedada de prueba"
  value       = aws_route53_zone.test_zone.zone_id
}