provider "aws" {
    region          = var.aws_region
}

provider "aws" {
    alias           = "virginia"
    region          = "us-east-1"
}

terraform {
    required_providers {
        aws = {
        source        = "hashicorp/aws"
        version       = "~> 4.30"
        }
    }
    backend "s3" {

    }
}