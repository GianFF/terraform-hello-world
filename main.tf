module "vpc" {
  source = "./modules/vpc"

  cidr_block = "10.0.0.0/16"
}

module "security_groups" {
  source = "./modules/sg"

  vpc_id = module.vpc.vpc_id
}

module "alb" {
  source = "./modules/alb"

  vpc_id          = module.vpc.vpc_id
  security_groups = [module.security_groups.alb_security_group_id]
  subnet_ids      = module.vpc.subnet_ids
}

module "ecs" {
  source = "./modules/ecs"

  vpc_id               = module.vpc.vpc_id
  subnet_ids           = module.vpc.subnet_ids
  security_groups      = [module.security_groups.ecs_security_group_id]
  alb_target_group_arn = module.alb.target_group_arn
}

module "ecs_autoscaling" {
  source              = "./modules/appautoscaling"
  resource_id         = "service/${module.ecs.ecs_cluster_name}/${module.ecs.ecs_service_name}"
  min_capacity        = 1
  max_capacity        = 5
  scale_out_threshold = 60
  scale_in_threshold  = 30
}

module "api_gw_alb" {
  source           = "./modules/api-gw-alb"
  name             = "ecs-api-gw"
  alb_listener_arn = module.alb.alb_listener_arn
  method           = "ANY"
  path             = "/{proxy+}"
}

module "custom_domain" {
  source         = "./modules/route53"
  domain_name    = "api.edymberg.com"
  certificate_arn = module.certificate.acm_certificate_arn
  api_id         = module.api_gw_alb.aws_apigatewayv2_api_id
}
