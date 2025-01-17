provider "aws" {
  region = var.aws_region
}

terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.17.0"
    }
  }
  backend "s3" {
    bucket = "mentors-demo"
    key = "dev"
    region = "ap-south-1"
   }
}