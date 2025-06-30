resource "aws_ecs_cluster" "ecs_cluster" {
  name = "terraform-ecs-cluster"

  tags = {
    Name = "terraform-ecs-cluster"
  }
}

resource "aws_iam_role" "ecs_execution_role" {
  assume_role_policy = jsonencode({
    Version = "2012-10-17",
    Statement = [{
      Effect = "Allow",
      Principal = {
        Service = "ecs-tasks.amazonaws.com"
      },
      Action = "sts:AssumeRole"
    }]
  })

  tags = {
    Name = "terraform-ecs-iam-role"
  }
}

resource "aws_iam_role_policy_attachment" "ecs_execution_policy" {
  role       = aws_iam_role.ecs_execution_role.name
  policy_arn = "arn:aws:iam::aws:policy/service-role/AmazonECSTaskExecutionRolePolicy"
}

resource "aws_ecs_task_definition" "ecs_task" {
  family                   = "terraform-ecs-task-definition"
  requires_compatibilities = ["FARGATE"]
  network_mode             = "awsvpc"
  cpu                      = "256"
  memory                   = "512"
  execution_role_arn       = aws_iam_role.ecs_execution_role.arn

  container_definitions = jsonencode([
    {
      name  = "hello"
      image = "nginxdemos/hello"
      portMappings = [
        {
          containerPort = 80
          hostPort      = 80
        }
      ]
    }
  ])

  tags = {
    Name = "terraform-ecs-task-definition"
  }
}

resource "aws_ecs_service" "ecs_service" {
  name            = "terraform-ecs-service"
  cluster         = aws_ecs_cluster.ecs_cluster.id
  task_definition = aws_ecs_task_definition.ecs_task.arn
  launch_type     = "FARGATE"
  desired_count   = 1

  network_configuration {
    subnets         = var.subnet_ids
    security_groups = var.security_groups
    assign_public_ip = true
  }

  depends_on = [aws_iam_role_policy_attachment.ecs_execution_policy]

  load_balancer {
    target_group_arn = var.alb_target_group_arn
    container_name   = "hello"
    container_port   = 80
  }

  tags = {
    Name = "terraform-ecs-service"
  }
}
