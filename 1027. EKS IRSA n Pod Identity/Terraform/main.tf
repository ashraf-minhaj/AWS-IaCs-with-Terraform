provider "aws" {
  region     = var.aws_region
  access_key = "test"
  secret_key = "test"

  skip_credentials_validation = true
  skip_metadata_api_check     = true
  skip_requesting_account_id  = true
  s3_use_path_style           = true

  endpoints {
    iam     = var.endpoint
    # vpc     = var.endpoint
    sts     = var.endpoint
    ec2     = var.endpoint
    eks     = var.endpoint
    route53 = var.endpoint
  }
}

terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.17.0"
    }
  }
}