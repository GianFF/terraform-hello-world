# Crea una API Gateway HTTP API (v2) para exponer el ALB (y por ende tu ECS)
resource "aws_apigatewayv2_api" "this" {
  name          = var.name
  protocol_type = "HTTP"
}

# Integra el API Gateway con el listener del ALB usando HTTP_PROXY
resource "aws_apigatewayv2_integration" "alb_integration" {
  api_id           = aws_apigatewayv2_api.this.id
  integration_type = "HTTP_PROXY"
  integration_method = "ANY"
  integration_uri  = var.alb_listener_arn
  payload_format_version = "1.0"
}

# Ruta que expone el API Gateway (ejemplo: ANY /{proxy+})
resource "aws_apigatewayv2_route" "default" {
  api_id    = aws_apigatewayv2_api.this.id
  route_key = "${var.method} ${var.path}"
  target    = "integrations/${aws_apigatewayv2_integration.alb_integration.id}"
}

# Stage por defecto para la API Gateway HTTP API
resource "aws_apigatewayv2_stage" "default" {
  api_id      = aws_apigatewayv2_api.this.id
  name        = "$default"
  auto_deploy = true
}
