variable "aws_region" {
	default = "ap-south-1"
}

variable "aws_access_key" {
default = ""
}
variable "aws_secret_key" {
default = ""
}

variable "component_prefix" {
  default = "minhaj"
}

variable "component_name" {
  default = "ec2-waker"
}

# store the zip file here
variable "bucket_name" {
	default = "ec2-waker-bucket"
}

variable "archive_file_type" {
  default = "zip"
}

variable "s3_key" {
  default     = "lambda/.zip"
  description = "Store zip file in this bucket path"
}

variable "lambda_handler" {
  default = "ec2waker"
}

variable "lambda_runtime" {
  default = "python3.9"
}

variable "lambda_timeout" {
  default = "10"
}