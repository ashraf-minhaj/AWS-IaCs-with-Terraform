variable "aws_region" {

}

variable "component_prefix" {
  default = ""
}

variable "component_name" {
  default = ""
}

variable "component_postfix" {
  # default = "dev"
}

# ec2
variable "ec2_profile" {
  default = "profile"
}

variable "ec2_launch_template" {
  default = "launch-template"
}

variable "ami_id" {
  default = "ami-0434196a03595d088"
}

variable "instance_type" {

}

variable "ssh_key" {
  default = "--key"
}

# autoscale group
variable "autoscale_group" {
  default = "asg"
}

# cludwatch alarm
variable "clw_alarm" {
  default = "cpuutilization-alarm"
}

# acm, route53
variable "hosted_zone_name" {
  default = "-.com"
}

variable "subdomain_name" {

}