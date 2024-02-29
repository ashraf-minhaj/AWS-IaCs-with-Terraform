locals {
  component           = "${var.component_prefix}-${var.component_name}"
  ec2_profile         = "${var.component_prefix}-${var.component_name}-${var.ec2_profile}-${var.component_postfix}"
  ec2_launch_template = "${var.component_prefix}-${var.component_name}-${var.ec2_launch_template}-${var.component_postfix}"
  s3_origin_id        = "${var.component_prefix}-bucket-oid-${var.component_postfix}"
  docker_image_tag    = "latest"
  # docker_image_tag    = trimspace(file("../scripts/tmp/docker_image_tag.txt"))
}