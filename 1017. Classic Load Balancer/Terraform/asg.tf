resource "aws_autoscaling_group" "asg" {
    name                            = "${local.component}-asg-${var.component_postfix}" 
    # availability_zones              = ["${var.aws_region}a", "${var.aws_region}b"] # , "${var.aws_region}c"
    desired_capacity                = 1
    max_size                        = 2
    min_size                        = 1

    vpc_zone_identifier             = [ aws_subnet.phitron_vpc_pub1.id, 
                                        aws_subnet.phitron_vpc_pub2.id  ]
    health_check_type               = "ELB"
    load_balancers                  = [ aws_elb.load_balancer.id ]
    health_check_grace_period       = 100
    # force_delete                    = false

    launch_template {
        id                          = "${aws_launch_template.machine_template.id}"
        version                     = "$Latest"
    }
}

resource "aws_autoscaling_policy" "asg_policy_scale_up" {
    name                            = "${local.component}-asg-step_up_policy-${var.component_postfix}"
    autoscaling_group_name          = "${aws_autoscaling_group.asg.name}"
    adjustment_type                 = "ChangeInCapacity"
    policy_type                     = "StepScaling"
    estimated_instance_warmup       = 300

    step_adjustment {
        scaling_adjustment          = 1
        metric_interval_lower_bound = 0
    }
}

resource "aws_autoscaling_policy" "asg_policy_scale_down" {
    name                            = "${local.component}-asg-step_down_policy-${var.component_postfix}"
    autoscaling_group_name          = "${aws_autoscaling_group.asg.name}"
    adjustment_type                 = "ChangeInCapacity"
    policy_type                     = "StepScaling"
    estimated_instance_warmup       = 300

    step_adjustment {
        scaling_adjustment          = -1
        metric_interval_lower_bound = 0
        # metric_interval_upper_bound = 1
    }
}
