output "api_gateway_id" {
  description = "The ID of the API Gateway"
  value       = aws_apigatewayv2_api.this.id
}

output "api_gateway_endpoint" {
  description = "Public URL of the API Gateway"
  value       = aws_apigatewayv2_api.this.api_endpoint
}

output "aws_apigatewayv2_api_id" {
  value       = aws_apigatewayv2_api.this.id
  description = "ID de la API Gateway HTTP API v2 creada"
}

output "api_stage_name" {
  description = "Stage name of the deployed API"
  value       = aws_apigatewayv2_stage.default.name
}
