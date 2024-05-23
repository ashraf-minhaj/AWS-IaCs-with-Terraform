locals {
  sg_name     = "${var.component_prefix}-lbsg-${var.component_postfix}"
  vpc_name    = "${var.component_prefix}-${var.vpc}-${var.component_postfix}"
  igw_name    = "${var.component_prefix}-igw-${var.component_postfix}"
  pub_rt_name = "${var.component_prefix}-pubrt-${var.component_postfix}"
}