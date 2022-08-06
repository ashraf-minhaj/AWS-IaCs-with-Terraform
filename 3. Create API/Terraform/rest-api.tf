resource "aws_api_gateway_rest_api" "rest_api" {
	name = "${var.rest_api_name}"
}