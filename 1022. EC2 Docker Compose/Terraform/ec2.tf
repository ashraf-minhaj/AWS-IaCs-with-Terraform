resource "aws_instance" "ec2_instance" {
  launch_template {
    id      = aws_launch_template.machine_template.id
    version = "$Latest"
  }
  iam_instance_profile = aws_iam_instance_profile.instance_profile.id

  tags = {
    Name = "test-min-instance"
  }

  lifecycle {
    create_before_destroy = true
  }
}