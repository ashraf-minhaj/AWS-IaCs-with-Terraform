variable "aws_region" {
	default = "ap-south-1"
}


variable "rest_api_name" {
	default = "idiotbot-api"
}

variable "component_prefix" {
  default = "minhaj"
}

variable "component_name" {
  default = "idiotbot"
}

# store the zip file here
variable "bucket_name" {
	default = "idiotbot-files"
}

variable "archive_file_type" {
  default = "zip"
}

variable "s3_key" {
  default     = "lambda/idiotbot.zip"
  description = "Store zip file in this bucket path"
}

variable "lambda_handler" {
  default = "query_handler"
}

variable "lambda_runtime" {
  default = "python3.9"
}

variable "lambda_timeout" {
  default = "5"
}
