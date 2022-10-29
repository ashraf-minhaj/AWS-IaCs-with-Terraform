provider "aws" {
	access_key = "${var.aws_access_key}"
    secret_key = "${var.aws_secret_key}"
    region  = "${var.aws_region}"
}

# minhaj - back-bencher
locals {
  resource_component = "${var.component_prefix}-${var.component_name}"
}