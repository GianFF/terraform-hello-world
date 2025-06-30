output "alb_dns_name" {
  value       = "http://${aws_lb.ecs_alb.dns_name}"
  description = "DNS público del Application Load Balancer"
}

output "target_group_arn" {
  value       = aws_lb_target_group.ecs_tg.arn
  description = "ARN del target group del ALB"
}