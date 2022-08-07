provider "aws" {
	region  = "${var.aws_region}"
	shared_credentials_files = ["C:/Users/HP/.aws/credentials"]
	profile = "default"
}

# minhaj - idiotbot
locals {
  resource_component = "${var.component_prefix}-${var.component_name}"
}