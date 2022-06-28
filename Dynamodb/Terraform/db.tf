resource "aws_dynamodb_table" "dynamodb_table" {
	name = "${var.table_name}"
	billing_mode = "${var.table_billing_mode}"
	hash_key = "${var.table_primary_key}"
	attribute {
	  name = "${var.table_primary_key}"
	  type = "${var.table_primary_key_data_type}"
	} 
}