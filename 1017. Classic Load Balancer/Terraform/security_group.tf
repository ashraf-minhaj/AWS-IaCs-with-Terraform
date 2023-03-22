resource "aws_security_group" "ec2_security_group" {
    name                    = "${local.component}-ec2-sg-${var.component_postfix}"
    description             = "Public internet access"
    vpc_id                  = aws_vpc.vpc.id
  
    tags = {
        Name                = "${local.component}-ec2-sg-${var.component_postfix}"
        Role                = "public"
        Project             = "${local.component}"
        Environment         = var.component_postfix
        ManagedBy           = "terraform"
    }
    dynamic "ingress" {
      for_each              = [ 22, 80 ]
      iterator              = port 
      content {
        from_port           = port.value
        to_port             = port.value
        protocol            = "tcp"
        cidr_blocks         = ["0.0.0.0/0"]
        security_groups     = [ aws_security_group.lb_security_group.id ]
      }
    }
    egress {
        from_port           = 0
        to_port             = 0
        protocol            = "-1"
        cidr_blocks         = ["0.0.0.0/0"]
    }
}

resource "aws_security_group" "lb_security_group" {
    name                    = "${local.component}-lb-sg-${var.component_postfix}"
    description             = "Public internet access"
    vpc_id                  = aws_vpc.vpc.id
  
    tags = {
        Name                = "${local.component}-lb-sg-${var.component_postfix}"
        Role                = "public"
        Project             = "${local.component}"
        Environment         = var.component_postfix
        ManagedBy           = "terraform"
    }
    dynamic "ingress" {
        for_each            = [ 443 ]
        iterator            = port 
        content {
            from_port       = port.value
            to_port         = port.value
            protocol        = "tcp"
            cidr_blocks     = ["0.0.0.0/0"]
        }
    }
    egress {
        from_port           = 0
        to_port             = 0
        protocol            = "-1"
        cidr_blocks         = ["0.0.0.0/0"]
    }
}

