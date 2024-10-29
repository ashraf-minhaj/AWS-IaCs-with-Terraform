resource "aws_ecs_cluster" "ecs_cluster" {
    name = "cluster-test"  
}

# ECS task definition
resource "aws_ecs_task_definition" "task_definition" {
    family                        = "app-test"
    network_mode                  = "awsvpc"
    memory                        = "512"         # mb bro
    cpu                           = "256"         # Defining the task-level CPU
    requires_compatibilities      = ["FARGATE"]

    # Task execution role (Replace "XXX" with your IAM role ARN)
    execution_role_arn = aws_iam_role.ecs_task_execution_role.arn

    # lifecycle {
    #     create_before_destroy = true
    # }

    # Container definition
    container_definitions = jsonencode([
        {
            name                    = "app-container-test"
            image                   = "669201380121.dkr.ecr.ap-southeast-1.amazonaws.com/repository-test:4"
            cpu                     = 256
            memory                  = 512
            port_mappings = [
                {
                    container_port  = 80
                    host_port       = 80
                    protocol        = "tcp"
                }
            ]
            logConfiguration = {
            logDriver = "awslogs"
            options   = {
                "awslogs-group"         = "fargate-logs-test"
                "awslogs-region"        = var.aws_region
                "awslogs-stream-prefix" = "ecs"
            }
        }
        }
    ])
}

resource "aws_ecs_service" "service" {
    name            = "app-service-test"
    cluster         = aws_ecs_cluster.ecs_cluster.id
    task_definition = aws_ecs_task_definition.task_definition.arn
    desired_count   = 1
    launch_type     = "FARGATE"

    # Network configuration
    network_configuration {
        subnets          = data.aws_subnets.default.ids
        security_groups  = [ aws_security_group.ecs_tasks_sg.id ]
        assign_public_ip = true
    }
    
    # load_balancer {
        # attach your load balancer here
    # }
}

# task execution role
resource "aws_iam_role" "ecs_task_execution_role" {
  name = "app-role-test"

  assume_role_policy = jsonencode({
    Version = "2012-10-17",
    Statement = [
      {
        Effect = "Allow",
        Action = ["sts:AssumeRole"],
        Principal = {
          Service = "ecs-tasks.amazonaws.com"
        }
      }
    ]
  })
  
  inline_policy {
    name        = "cloudwatch-logs-policy"
    policy = jsonencode({
      Version = "2012-10-17",
      Statement = [
        {
          Effect   = "Allow",
          Action   = [
            "logs:CreateLogGroup",
            "logs:CreateLogStream",
            "logs:PutLogEvents"
            # Add more CloudWatch Logs permissions as needed
          ],
          Resource = ["arn:aws:logs:*:*:*"]
        }
      ]
    })
  }
}

# attach a managed policy too
resource "aws_iam_role_policy_attachment" "ecs_task_execution" {
    role       = aws_iam_role.ecs_task_execution_role.name
    # policy_arn = "arn:aws:iam::aws:policy/service-role/AmazonECSTaskExecutionRolePolicy"
    policy_arn = "arn:aws:iam::aws:policy/AmazonEC2ContainerRegistryReadOnly"
}