variable "aws_region" {
    default = "ap-southeast-1"
}

variable "component_name" {
    default = ""
}

variable "common_key" {
    default = "app"
}

variable "common_value" {
    default = ""
}

# ec2
variable "ami" {
    default = "ami-0434196a03595d088"
}

variable "instance_type" {
    default = "t2.micro"
}

variable "key_name" {
    default =""
}

variable "security_group_name" {
    default = ""
}

# database creds
variable "db_user_name" {
    # default = ""
}

variable "db_admin_pass" {
    # default = "Testpassword@123"
}

# cloudfront
variable "cloudfront_price_class" {
    default = "PriceClass_200"
}

# ACM
variable "subdomain_name" {
    default = ""
}

# route53
variable "hosted_zone_name" {
    default = ""
}