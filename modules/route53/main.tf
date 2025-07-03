# 1. Crear la zona hospedada en Route 53 (si no existe)
resource "aws_route53_zone" "zone" {
  name = var.domain_name
}

# 2. Crear el dominio custom en API Gateway v2
resource "aws_apigatewayv2_domain_name" "custom" {
  domain_name = var.domain_name
  domain_name_configuration {
    certificate_arn = var.certificate_arn
    endpoint_type   = "REGIONAL"
    security_policy = "TLS_1_2"
  }
}

# 3. Crear el API mapping para asociar el dominio custom con el API Gateway v2
resource "aws_apigatewayv2_api_mapping" "custom" {
  api_id      = var.api_id
  domain_name = aws_apigatewayv2_domain_name.custom.id
  stage       = "$default"
}
