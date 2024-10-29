data "aws_iam_policy_document" "ecs_node_policy" {
  statement {
    actions = ["sts:AssumeRole"]
    effect  = "Allow"

    principals {
      type        = "Service"
      identifiers = ["ec2.amazonaws.com"]
    }
  }
}

resource "aws_iam_role" "ecs_node_role" {
  name               = local.node_role_name
  assume_role_policy = data.aws_iam_policy_document.ecs_node_policy.json
}

resource "aws_iam_role_policy_attachment" "ecs_node_role_policy" {
  role       = aws_iam_role.ecs_node_role.name
  policy_arn = "arn:aws:iam::aws:policy/service-role/AmazonEC2ContainerServiceforEC2Role"
}

resource "aws_iam_instance_profile" "ecs_node" {
  # instance profile is a container for an IAM role that you can use to pass role information to an EC2 instance when the instance starts
  name_prefix = "demo-ecs-node-profile"
  path        = "/ecs/instance/"
  role        = aws_iam_role.ecs_node_role.name
}

resource "aws_security_group" "ecs_node_sg" {
  # its required to pull image to start service later
  name_prefix = local.node_sg
  vpc_id      = aws_vpc.vpc.id

  egress {
    from_port   = 0
    to_port     = 65535
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

data "aws_ssm_parameter" "ecs_node_ami" {
  name = "/aws/service/ecs/optimized-ami/amazon-linux-2/recommended/image_id"
}

resource "aws_launch_template" "ecs_ec2" {
  name                   = local.node_name
  image_id               = data.aws_ssm_parameter.ecs_node_ami.value
  instance_type          = "t2.micro"
  vpc_security_group_ids = [aws_security_group.ecs_node_sg.id]

  iam_instance_profile {
    arn = aws_iam_instance_profile.ecs_node.arn
  }
  monitoring {
    enabled = true
  }

  user_data = base64encode(<<-EOF
      #!/bin/bash
      echo ECS_CLUSTER=${aws_ecs_cluster.cluster.name} >> /etc/ecs/ecs.config;

      # required to pass ECS cluster name, so AWS can register EC2 instance as node of ECS cluster
    EOF
  )
}

resource "aws_autoscaling_group" "ecs_node_asg" {
  name                      = local.node_asg_name
  vpc_zone_identifier       = aws_subnet.public_subnets[*].id
  desired_capacity          = 1
  min_size                  = 1
  max_size                  = 1
  health_check_grace_period = 10
  health_check_type         = "EC2"
  protect_from_scale_in     = false

  launch_template {
    id      = aws_launch_template.ecs_ec2.id
    version = "$Latest"
  }

  tag {
    key                 = "AmazonECSManaged"
    value               = ""
    propagate_at_launch = true
  }
}