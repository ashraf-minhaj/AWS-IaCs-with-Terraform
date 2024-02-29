resource "aws_iam_role" "ec2_role" {
  name = "${local.component}-role-${var.component_postfix}"

  assume_role_policy = jsonencode(
    {
      "Version" : "2012-10-17",
      "Statement" : [
        {
          "Action" : "sts:AssumeRole",
          "Principal" : {
            "Service" : "ec2.amazonaws.com"
          },
          "Effect" : "Allow",
          "Sid" : ""
        }
      ]
  })
}

resource "aws_iam_role_policy" "ec2_policy" {
  name = "${local.component}-policy-${var.component_postfix}"
  role = aws_iam_role.ec2_role.id

  policy = jsonencode(
    {
      "Version" : "2012-10-17",
      "Statement" : [
        {
          "Effect" : "Allow",
          "Action" : [
            "logs:CreateLogGroup",
            "logs:CreateLogStream",
            "logs:DescribeLogStreams",
            "logs:PutLogEvents"
          ],
          "Resource" : "arn:aws:logs:${var.aws_region}:${data.aws_caller_identity.current.account_id}:*"
        }
      ]
  })
}

# cloudinit configs - user data
locals {
  provision_config = <<-EOF
        #cloud-config
        ${jsonencode({
  write_files = [
    # {
    #   path        = "/home/ec2-user/dockerhub_token.txt"
    #   permissions = "0644"
    #   encoding    = "b64"
    #   content     = filebase64("../scripts/dockerhub_token.txt")
    # },
    # {
    #   path        = "/home/ec2-user/.env"
    #   permissions = "0644"
    #   encoding    = "b64"
    #   content     = filebase64("../../app/.env")
    # },
    {
      path        = "/home/ec2-user/docker-compose.yml"
      permissions = "0644"
      encoding    = "b64"
      content     = filebase64("../app/docker-compose.yml")
    },
  ]
})
}
  EOF
}

data "cloudinit_config" "config" {
  gzip          = false
  base64_encode = true

  part {
    content_type = "text/cloud-config"
    filename     = "cloud-config-cred-provision.yaml"
    content      = local.provision_config
  }

  part {
    content_type = "text/x-shellscript"
    filename     = "setup_dependencies.sh"
    content      = <<-EOF
        #!/bin/bash
        cd /home/ec2-user/
        sudo yum update -y 
        sudo yum install docker -y
        sudo service docker start 
        sudo usermod -a -G docker ec2-user 
        sudo systemctl enable docker.service
        sudo systemctl start docker.service

        sudo curl -L https://github.com/docker/compose/releases/latest/download/docker-compose-$(uname -s)-$(uname -m) -o /usr/local/bin/docker-compose
        sudo chmod +x /usr/local/bin/docker-compose
        # docker-compose version

        touch i_ran.txt
        # sudo curl "https://awscli.amazonaws.com/awscli-exe-linux-x86_64.zip" -o "awscliv2.zip"
        # sudo unzip awscliv2.zip
        # sudo ./aws/install
        
        # sudo docker login --username=user --password-stdin < dockerhub_token.txt
        sudo -E TAG=${local.docker_image_tag} docker-compose up
        EOF
  }
}

resource "aws_iam_instance_profile" "instance_profile" {
  name = local.ec2_profile
  role = aws_iam_role.ec2_role.name

  tags = {
    app  = "${var.component_prefix}"
    Name = "${var.component_prefix}-${var.component_name}-ec2prof-${var.component_postfix}"
    env  = "${var.component_postfix}"
  }
}

resource "aws_launch_template" "machine_template" {
  name                   = local.ec2_launch_template
  image_id               = var.ami_id
  instance_type          = var.instance_type
  key_name               = var.ssh_key
  user_data              = data.cloudinit_config.config.rendered
  vpc_security_group_ids = [aws_security_group.ec2_security_group.id]

  metadata_options {
    http_tokens = "required"
  }

  iam_instance_profile {
    name = aws_iam_instance_profile.instance_profile.name
  }

  tag_specifications {
    resource_type = "instance"
    tags = {
      Name   = "${local.component}-${var.component_postfix}" # name of the ec2 instance
      Source = "Autoscaling"
    }
  }

  monitoring {
    enabled = false
  }

  tags = {
    app = "${var.component_prefix}"
    env = "${var.component_postfix}"
  }
}

