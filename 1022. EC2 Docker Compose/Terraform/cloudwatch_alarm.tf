resource "aws_cloudwatch_metric_alarm" "clw_cpu_alarm" {
  alarm_name          = local.clw_cpu_alarm
  comparison_operator = "GreaterThanOrEqualToThreshold"
  evaluation_periods  = 2
  metric_name         = "CPUUtilization"
  namespace           = "AWS/EC2"
  period              = 30
  statistic           = "Average"
  threshold           = 70

  dimensions = {
    AutoScalingGroupName = aws_autoscaling_group.asg.name
  }

  alarm_description = "This metric monitors ec2 cpu utilization"
  alarm_actions     = [aws_autoscaling_policy.asg_policy_scale_up.arn]
  ok_actions        = [aws_autoscaling_policy.asg_policy_scale_down.arn]
  actions_enabled   = "true"

  tags = {
    app = "${var.component_prefix}"
    env = "${var.component_postfix}"
  }
}