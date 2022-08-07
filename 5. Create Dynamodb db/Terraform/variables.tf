variable "aws_region" {
	default = "ap-south-1"
}

# variable "aws_access_key" {
# default = ""
# }
# variable "aws_secret_key" {
# default = ""
# }

variable "table_name" {
  default = "not-a-dining-table"
}

variable "table_billing_mode" {
  description = "Controls how you are charged for read and write throughput and how you manage capacity."
  default = "PAY_PER_REQUEST"
}

variable "table_primary_key" {
  default = "employeeID"
  description = "hash key"
}

variable "table_primary_key_data_type" {
  default = "S"
}

# variable "environment" {
#   default = "test"
# }