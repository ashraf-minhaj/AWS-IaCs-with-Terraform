variable "aws_region" {
  default = "ap-southeast-1"
}

variable "default_tags" {
  type = map(string)
  default = {
    Project   = "test"
    ManagedBy = "Terraform"
    Owner     = "Ashraf Minhaj"
  }
}

variable "frontend_dir" {
  default = "../src/frontend"
}

variable "backend_dir" {
  default = "../src/backend"
}

variable "frontend_repo_name" {
  default = "frontend"
}

variable "backend_repo_name" {
  default = "backend"
}