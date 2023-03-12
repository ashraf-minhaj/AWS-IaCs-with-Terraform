provider "aws" {
  region            = "ap-southeast-1"
}

terraform {
  required_providers {
    aws = {
      source        = "hashicorp/aws"
      version       = "~> 4.30"
    }
  }
}

