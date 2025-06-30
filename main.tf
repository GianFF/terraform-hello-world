module "vpc" {
  source = "./modules/vpc"

  cidr_block = "10.0.0.0/16"
}

# Data source para encontrar la última imagen de Amazon Linux 2
# data "aws_ami" "amazon_linux_2" {
#   most_recent = true
#   owners      = ["amazon"]

#   filter {
#     name   = "name"
#     values = ["amzn2-ami-hvm-*-x86_64-gp2"]
#   }

#   filter {
#     name   = "virtualization-type"
#     values = ["hvm"]
#   }
# }

# module "ec2" {
#   source           = "./modules/ec2"
#   ami              = data.aws_ami.amazon_linux_2.id
#   instance_type    = "t2.micro"
#   subnet_id        = module.vpc.subnet_id # TODO: Esto cambio a subnet_ids
#   vpc_id           = module.vpc.vpc_id
#   public_key_path  = "~/.ssh/id_rsa.pub"
#   # user_data        = file("${path.module}/scripts/web_server_hello-world_script.sh")
#   user_data        = file("${path.module}/scripts/web_server_docker-image_script.sh")
# }

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