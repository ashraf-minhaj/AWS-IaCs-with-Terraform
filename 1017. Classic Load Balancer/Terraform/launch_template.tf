resource "aws_iam_role" "ec2_role" {
  name  = "${local.component}-role-${var.component_postfix}"

  assume_role_policy = jsonencode(
    {
        "Version": "2012-10-17",
        "Statement": [
            {
                "Action": "sts:AssumeRole",
                "Principal": {
                    "Service": "ec2.amazonaws.com"
                    },
                "Effect": "Allow",
                "Sid": ""
            }
        ]
    })
}

resource "aws_iam_role_policy" "ec2_policy" {
  name    = "${local.component}-policy-${var.component_postfix}"
  role    = "${aws_iam_role.ec2_role.id}"

  policy  = jsonencode(
    {
        "Version": "2012-10-17",
        "Statement": [
            {
                "Effect": "Allow",
                "Action": [
                    "logs:CreateLogGroup",
                    "logs:CreateLogStream",
                    "logs:DescribeLogStreams",
                    "logs:PutLogEvents"
                    ],
                "Resource": "arn:aws:logs:*:*:*"
            }
        ]
    })
}

# locals {
#   provision_config= <<-END
#     #cloud-config
#     ${jsonencode({
#       write_files = [
#         {
#           path        = "/home/ubuntu/project/src/main.py"
#           permissions = "0644"
#           encoding    = "b64"
#           content     = filebase64("../src/main.py")
#         },
#       ]
#     })}
#   END
# }

data "cloudinit_config" "config" {
    gzip                = false
    base64_encode       = true

    # part {
    #     content_type      = "text/cloud-config"
    #     filename          = "cloud-config_provision.yaml"
    #     content           = local.provision_config
    # }

    part {
        content_type      = "text/x-shellscript"
        filename          = "setup_dependencies.sh"
        # content      = filebase64("./setup.sh")
        content           = <<-EOF
        #!/bin/bash
        touch /home/ubuntu/x.txt
        apt update -y
        apt install nginx
        sudo ufw allow 80
        echo “Hello World from $(hostname -f)” > /var/www/html/index.html

        EOF
    }
}

resource "aws_iam_instance_profile" "instance_profile" {
    name                  = "${local.ec2_profile}"
    role                  = "${aws_iam_role.ec2_role.name}"
}

resource "aws_launch_template" "machine_template" {
    name                  = "${local.ec2_launch_template}"
    image_id              = "${var.ami_id}"
    instance_type         = "${var.instance_type}"
    key_name              = "${var.ssh_key}"
    # user_data             = filebase64("./setup2.sh")
    # user_data             = data.cloudinit_config.config.rendered
    user_data             = "${filebase64("../scripts/simple_page.sh")}"
    vpc_security_group_ids = [ aws_security_group.ec2_security_group.id ]

    iam_instance_profile {
        name              = "${aws_iam_instance_profile.instance_profile.name}"
    }

    tag_specifications {
        resource_type     = "instance"
        tags = {
            Name          = "${local.component}-${var.component_postfix}"
            Source        = "Autoscaling"
        } 
    }

    monitoring {
    enabled             = true
    }
}