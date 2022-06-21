variable "bucket_name" {
	default = "min-test-files"
}

variable "aws_s3_bucket_acl" {
    default = "public"
}

variable "aws_access_key" {
default = ""
}
variable "aws_secret_key" {
default = ""
}

variable "region" {
    default = "ap-south-1"
}