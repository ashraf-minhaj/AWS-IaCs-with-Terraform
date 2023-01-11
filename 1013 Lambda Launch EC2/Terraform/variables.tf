variable "aws_region" {
  # default = "ap-southeast-1"
}

variable "component_prefix" {
  default = "min"
}

variable "component_postfix_env_tag" {
  # default = "test"
}


variable "lambda_artifacts_bucket" {
  default = "lambda-xxxxx"
}

variable "archive_file_type" {
  default = "zip"
}

# lambda
variable "launcher_name" {
  default = "lambda-ec2-launcher"
}

variable "launcher_handler" {
  default = "launcher_handler"
}

variable "launcher_key" {
  default = "launcher.zip"
}

variable "launcher_timeout" {
  default = "15"
}

variable "launcher_runtime" {
  default = "python3.9"
}


# ec2
variable "ami_name" {
  default = "xxxxx"
}


variable "instance_clone_name" {
  default = ""
}

# variable "instance_ami" {
#   default = "ami-0000"
# }

variable "instance_type" {
  # default = "t2.medium"
  # default = "t2.micro"   # for now
}

variable "ssh_key" {
  default = "xxxx"
}

variable "security_groups" {
  default = "launch-wizard-00"
}
