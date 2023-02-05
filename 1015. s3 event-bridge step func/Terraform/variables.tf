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

variable "lambda1_name" {
  default = "lambda1"
}

variable "lambda2_name" {
  default = "lambda2"
}

variable "lambdaErr_name" {
  default = "lambdaErr"
}

# store the zip file here
variable "bucket_name" {
	default = "min-lambdas"
}

variable "archive_file_type" {
  default = "zip"
}

variable "lamba1_s3_key" {
  default     = "lambda/lambda1.zip"
  description = "Store zip file in this bucket path"
}

variable "lamba2_s3_key" {
  default     = "lambda/lambda2.zip"
  description = "Store zip file in this bucket path"
}

variable "lambaErr_s3_key" {
  default     = "lambda/lambdaErr.zip"
  description = "Store zip file in this bucket path"
}

variable "lambda1_handler" {
  default = "func1_handler"
}

variable "lambda2_handler" {
  default = "func2_handler"
}

variable "lambdaErr_handler" {
  default = "error_handler"
}

variable "lambda_runtime" {
  default = "python3.9"
}

variable "lambda_timeout" {
  default = "5"
}

variable "step_function_name" {
  default = "state-machine"
}

variable "source_bucket_name" {
  default = "minhaj-rnd"
}