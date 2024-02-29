# resource "aws_lb_target_group" "lb_taget_grp" {
#   name = "${local.component}-alb-tg-${var.component_postfix}"
#   # target_type           = "application"
#   port       = var.ec2_ingress_port
#   protocol   = "HTTP"
#   vpc_id     = data.aws_vpc.vpc.id
#   slow_start = var.slow_start_period

#   load_balancing_algorithm_type = "round_robin"

#   # stickiness {
#   #     enabled           = false
#   #     type              = 
#   # }

#   health_check {
#     enabled             = true # change 
#     path                = var.health_check_path
#     port                = var.ec2_ingress_port
#     interval            = 65
#     protocol            = "HTTP"
#     matcher             = "200"
#     timeout             = 60
#     healthy_threshold   = 2
#     unhealthy_threshold = 10
#   }

#   tags = {
#     app = "${var.component_prefix}"
#     env = "${var.component_postfix}"
#   }
# }


# resource "aws_lb" "load_balancer" {
#   name            = "${local.component}-alb-${var.component_postfix}"
#   internal        = false #tfsec:ignore:alb-not-public
#   idle_timeout    = 300
#   security_groups = [aws_security_group.lb_security_group.id]
#   # A load balancer cannot be attached to multiple subnets in the same Availability Zone
#   subnets = [aws_subnet.subnet_pub1.id,
#     aws_subnet.subnet_pub2.id
#   ]
#   enable_deletion_protection = false # true keeps on deleting forever
#   drop_invalid_header_fields = true

#   tags = {
#     app = "${var.component_prefix}"
#     env = "${var.component_postfix}"
#   }
# }

# resource "aws_lb_listener" "forward" {
#   depends_on        = [aws_lb_target_group.lb_taget_grp]
#   load_balancer_arn = aws_lb.load_balancer.arn
#   port              = 443
#   protocol          = "HTTPS"
#   ssl_policy        = "ELBSecurityPolicy-TLS13-1-2-2021-06"
#   certificate_arn   = data.aws_acm_certificate.certificate.arn

#   default_action {
#     type             = "forward"
#     target_group_arn = aws_lb_target_group.lb_taget_grp.arn
#   }

#   tags = {
#     app = "${var.component_prefix}"
#     env = "${var.component_postfix}"
#   }
# }