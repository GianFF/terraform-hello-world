output "alb_security_group_id" {
  value = aws_security_group.sg_alb.id
}

output "ecs_security_group_id" {
  value = aws_security_group.sg_ecs.id
}
