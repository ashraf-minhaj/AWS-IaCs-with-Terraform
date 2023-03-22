locals {
    component               = "${var.component_prefix}-${var.component_name}"
    ec2_profile             = "${var.component_prefix}-${var.component_name}-${var.ec2_profile}-${var.component_postfix}"
    ec2_launch_template     = "${var.component_prefix}-${var.component_name}-${var.ec2_launch_template}-${var.component_postfix}"
    clw_cpu_alarm           = "${var.component_prefix}-${var.component_name}-${var.clw_alarm}-${var.component_postfix}"
}