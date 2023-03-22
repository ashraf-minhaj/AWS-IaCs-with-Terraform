resource "aws_lb_target_group" "lb_taget_grp" {
    name                            = "${local.component}-alb-tg-${var.component_postfix}"
    # target_type                     = "application"
    port                            = 80
    protocol                        = "HTTP"
    vpc_id                          = aws_vpc.vpc.id
    slow_start                      = 30

    load_balancing_algorithm_type   = "round_robin"
    # stickiness {
    #     enabled                   = false
    # }

    health_check {
        enabled                     = true
        path                        = "/index.html"
        port                        = 80
        interval                    = 30
        protocol                    = "HTTP" 
        matcher                     = "200"
        healthy_threshold           = 3
        unhealthy_threshold         = 3
    }
}


resource "aws_lb" "load_balancer" {
    name                            = "${local.component}-alb-${var.component_postfix}"
    internal                        = false
    idle_timeout                    = 300
    security_groups                 = [aws_security_group.lb_security_group.id]
    subnets                         = [ aws_subnet.vpc_pub1.id, 
                                        aws_subnet.vpc_pub2.id  ]
    enable_deletion_protection      = true
}

resource "aws_lb_listener" "forward" {
    load_balancer_arn               = aws_lb.load_balancer.arn
    port                            = 443
    protocol                        = "HTTPS"
    ssl_policy                      = "ELBSecurityPolicy-2016-08"
    certificate_arn                 = data.aws_acm_certificate.certificate.arn

    default_action {
        type                        = "forward"
        target_group_arn            = aws_lb_target_group.lb_taget_grp.arn
    }    
}