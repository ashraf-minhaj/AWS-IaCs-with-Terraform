resource "aws_security_group" "ec2_security_group" {
  name        = "${local.component}-ec2-sg-${var.component_postfix}"
  description = "Public internet access"
  vpc_id      = data.aws_vpc.vpc.id

  dynamic "ingress" {
    for_each = [22, var.ec2_ingress_port]
    iterator = port
    content {
      description = "Allow inbound traffic"
      from_port   = port.value
      to_port     = port.value
      protocol    = "tcp"
      cidr_blocks = ["0.0.0.0/0"] #tfsec:ignore:aws-ec2-no-public-ingress-sgr
      # security_groups = [aws_security_group.lb_security_group.id]
    }
  }
  egress {
    description = "Allow outbound traffic"
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"] #tfsec:ignore:no-public-egress-sgr
  }

  tags = {
    Name      = "${local.component}-ec2-sg-${var.component_postfix}"
    Role      = "public"
    ManagedBy = "terraform"
    app       = "${var.component_prefix}"
    env       = "${var.component_postfix}"
    ManagedBy = "terraform"
  }
}

# resource "aws_security_group" "lb_security_group" {
#   name        = "${local.component}-lb-sg-${var.component_postfix}"
#   description = "Public internet access"
#   vpc_id      = data.aws_vpc.vpc.id

#   dynamic "ingress" {
#     for_each = [443]
#     iterator = port
#     content {
#       description = "Allow inbound HTTPS traffic"
#       from_port   = port.value
#       to_port     = port.value
#       protocol    = "tcp"
#       #tfsec:ignore:no-public-ingress-sgr
#       cidr_blocks = ["0.0.0.0/0"]
#     }
#   }
#   egress {
#     description = "Allow outbound traffic"
#     from_port   = 0
#     to_port     = 0
#     protocol    = "-1"
#     cidr_blocks = ["0.0.0.0/0"] #tfsec:ignore:no-public-egress-sgr
#   }

#   tags = {
#     Name      = "${local.component}-lb-sg-${var.component_postfix}"
#     Role      = "public"
#     ManagedBy = "terraform"
#     app       = "${var.component_prefix}"
#     env       = "${var.component_postfix}"
#     ManagedBy = "terraform"
#   }
# }
