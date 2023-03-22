resource "aws_elb" "load_balancer" {
    name                        = "${local.component}-lb-${var.component_postfix}"
    subnets                     = [ aws_subnet.phitron_vpc_pub1.id, 
                                    aws_subnet.phitron_vpc_pub2.id  ]
    security_groups             = [ aws_security_group.lb_security_group.id ]

    # listener {
    #     instance_port           = 80
    #     instance_protocol       = "http"
    #     lb_port                 = 80
    #     lb_protocol             = "http"
    # }

    listener {
        instance_port           = 80
        instance_protocol       = "http"
        lb_port                 = 443
        lb_protocol             = "https"
        # ssl_certificate_id      = "${data.aws_acm_certificate.certificate.arn}"
        ssl_certificate_id = data.aws_acm_certificate.certificate.id
    }

    health_check {
        healthy_threshold       = 2
        unhealthy_threshold     = 2
        timeout                 = 3
        target                  = "HTTP:80/"
        interval                = 30
    }

    cross_zone_load_balancing   = true
    connection_draining         = true  # complete req then remove
    connection_draining_timeout = 400
}