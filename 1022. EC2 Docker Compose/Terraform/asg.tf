resource "aws_autoscaling_group" "asg" {
  name                      = "${local.component}-asg-${var.component_postfix}"
  desired_capacity          = var.desired_capacity
  max_size                  = var.max_instances
  min_size                  = var.min_instances
  health_check_type         = "ELB"
  health_check_grace_period = 3 * 60
  # force_delete                = false
  vpc_zone_identifier = [aws_subnet.subnet_pub1.id,
    aws_subnet.subnet_pub2.id
  ]
  target_group_arns = [aws_lb_target_group.lb_taget_grp.arn]

  launch_template {
    id      = aws_launch_template.machine_template.id
    version = "$Latest"
  }
}

resource "aws_autoscaling_policy" "asg_policy_scale_up" {
  name                      = "${local.component}-asg-step_up_policy-${var.component_postfix}"
  autoscaling_group_name    = aws_autoscaling_group.asg.name
  adjustment_type           = "ChangeInCapacity"
  policy_type               = "StepScaling"
  estimated_instance_warmup = 300

  step_adjustment {
    scaling_adjustment          = 1
    metric_interval_lower_bound = 0
  }
}

resource "aws_autoscaling_policy" "asg_policy_scale_down" {
  name                      = "${local.component}-asg-step_down_policy-${var.component_postfix}"
  autoscaling_group_name    = aws_autoscaling_group.asg.name
  adjustment_type           = "ChangeInCapacity"
  policy_type               = "StepScaling"
  estimated_instance_warmup = 160
  # cooldown                    = 160

  step_adjustment {
    scaling_adjustment          = -1
    metric_interval_lower_bound = 0
    # metric_interval_upper_bound = 1
  }
}
