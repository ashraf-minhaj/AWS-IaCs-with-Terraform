provider "aws" {
    region  = "${var.aws_region}"
	shared_credentials_files = ["/Users/ashrafminhaj/.aws"]
	profile = "default"
}
