locals {
  sg_name           = "${var.component_prefix}-lbsg-${var.component_postfix}"
  vpc_name          = "${var.component_prefix}-${var.vpc}-${var.component_postfix}"
  igw_name          = "${var.component_prefix}-igw-${var.component_postfix}"
  pub_rt_name       = "${var.component_prefix}-pubrt-${var.component_postfix}"
  cluster_name      = "${var.component_prefix}-cluster-${var.component_postfix}"
  node_role_name    = "${var.component_prefix}-role-${var.component_postfix}"
  role_profile_name = "${var.component_prefix}-role-prof-${var.component_postfix}"
  node_sg           = "${var.component_prefix}-node-sg-${var.component_postfix}"
  node_name         = "${var.component_prefix}-node-${var.component_postfix}"
  node_asg_name     = "${var.component_prefix}-asg-${var.component_postfix}"
}