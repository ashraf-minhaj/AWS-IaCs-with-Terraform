resource "aws_api_gateway_rest_api" "rest_api" {
	name = "${var.rest_api_name}"
}

# deploy
resource "aws_api_gateway_deployment" "deployment" {
  depends_on = [
    aws_api_gateway_integration.integration,
    aws_api_gateway_integration.lambda_root,
  ]

  rest_api_id = "${aws_api_gateway_rest_api.rest_api.id}"
  stage_name  = "test"
}

# get the url to trigger the api on terminal as output
output "base_url" {
  value = "${aws_api_gateway_deployment.deployment.invoke_url}"
}