variable "aws_region" {
  type    = string
  default = "ap-south-1"
}

variable "component_prefix" {
  type    = string
  default = "minhaj-infra"
}

variable "component_postfix" {
  type    = string
  default = "dev"
}

# VPC 
variable "vpc" {
  type    = string
  default = "vpc"
}

variable "vpc_cidr" {
  type    = string
  default = "10.0.0.0/16"
}

variable "public_subnet_cidr_blocks" {
  type        = list(string)
  description = "CIDR blocks for public subnets"
  default     = ["10.0.64.0/24", "10.0.65.0/24", "10.0.69.0/28"]
}

variable "private_subnet_cidr_blocks" {
  type        = list(string)
  description = "CIDR blocks for private subnets"
  default     = ["10.0.66.0/28", "10.0.67.0/28"]
}

variable "availability_zones" {
  type        = list(string)
  description = "A list of availability zones where resources will be deployed"
  default     = ["ap-south-1a", "ap-south-1b"]
}
