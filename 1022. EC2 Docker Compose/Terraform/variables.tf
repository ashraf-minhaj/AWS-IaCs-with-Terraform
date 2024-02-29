variable "aws_region" {
  default = "ap-southeast-1"
}

variable "component_prefix" {
  default = "test"
}

variable "component_name" {
  default = "min"
}

variable "component_postfix" {
  default = "dev"
}

# ec2
variable "ec2_profile" {
  default = "profile"
}

variable "ec2_launch_template" {
  default = "launch-template"
}

variable "ami_id" {
  default     = "ami-0a481e6d13af82399"
  description = "amazon linux 2023"
}

variable "instance_type" {
  default = "t2.micro"
}

variable "ssh_key" {
  default   = "min-test-key"
  sensitive = true
}

variable "slow_start_period" {
  default = 140
}

variable "ec2_ingress_port" {
  default = 8080
}


# autoscale group
variable "autoscale_group" {
  default = "asg"
}

variable "max_instances" {
  default = 2
}

variable "min_instances" {
  default = 1
}

variable "desired_capacity" {
  default = 1
  description = "desired number of ec2 instances"
}

# cludwatch alarm
variable "clw_alarm" {
  default = "cpuutilization-alarm"
}

# cci variables
variable "discord_webhook" {
  default = ""
  # export export TF_VAR_discord_webhook="potato"
}

# variable "docker_username" {
#   default = "x"
# }

# variable "dockerhub_token" {

# }
