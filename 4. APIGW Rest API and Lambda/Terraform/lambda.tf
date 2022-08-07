# Zip the Lamda function on the fly
data "archive_file" "source" {
  type        = "${var.archive_file_type}"
  source_dir  = "../files/"
  output_path = "../output-files/--.zip"
}

# upload zip to s3 and then update lamda function from s3
resource "aws_s3_bucket_object" "s3_bucket_obj" {
  bucket = "${aws_s3_bucket.s3_bucket.bucket}"
  key    = "${var.s3_key}"
  source = data.archive_file.source.output_path
}

/*
# connect this lambda with uploaded s3 zip file
# lambda needs code and iam_role
# "${aws_s3_bucket_object.file_upload.key}"
# resource - resource_name */
resource "aws_lambda_function" "lambda" {
    function_name   = "${local.resource_component}"
    s3_bucket       = aws_s3_bucket_object.s3_bucket_obj.bucket
    s3_key          = aws_s3_bucket_object.s3_bucket_obj.key
    role            = aws_iam_role.lambda_role.arn 
    handler         = "${local.resource_component}.${var.lambda_handler}"
    runtime         = "${var.lambda_runtime}"
	timeout			= "${var.lambda_timeout}"
}

/* Set up API
# All incoming requests to API Gateway must match with a configured resource -
# and method in order to be handled.
# The special path_part value "{proxy+}" activates proxy behavior, 
# which means that this resource will match any request path. 
# Similarly, the aws_api_gateway_method block uses a http_method of "ANY", 
# which allows any request method to be used. Taken together, 
# this means that all incoming requests will match this resource.
*/
resource "aws_api_gateway_resource" "proxy" {
  rest_api_id = "${aws_api_gateway_rest_api.rest_api.id}"
  parent_id   = "${aws_api_gateway_rest_api.rest_api.root_resource_id}"
  path_part   = "{proxy+}"
}

resource "aws_api_gateway_method" "proxy_method" {
  rest_api_id   = "${aws_api_gateway_rest_api.rest_api.id}"
  resource_id   = "${aws_api_gateway_resource.proxy.id}"
  http_method   = "ANY"
  authorization = "NONE"
}

/*
# connect with lambda **
# Each method on an API gateway resource has an integration which specifies 
# where incoming requests are routed. Add the following configuration to specify 
# that requests to this method should be sent to the Lambda function defined earlier:
*/
resource "aws_api_gateway_integration" "integration" {
  rest_api_id = "${aws_api_gateway_rest_api.rest_api.id}"
  resource_id = "${aws_api_gateway_method.proxy_method.resource_id}"
  http_method = "${aws_api_gateway_method.proxy_method.http_method}"

  integration_http_method = "POST"
  type                    = "AWS_PROXY"
  uri                     = "${aws_lambda_function.lambda.invoke_arn}"
}

/*
# :( but these are needed
# Unfortunately the proxy resource cannot match an empty path at the root of the API. 
# To handle that, a similar configuration must be applied to the 
# root resource that is built in to the REST API object:
*/
resource "aws_api_gateway_method" "proxy_root" {
  rest_api_id   = "${aws_api_gateway_rest_api.rest_api.id}"
  resource_id   = "${aws_api_gateway_rest_api.rest_api.root_resource_id}"
  http_method   = "ANY"
  authorization = "NONE"
}

resource "aws_api_gateway_integration" "lambda_root" {
  rest_api_id = "${aws_api_gateway_rest_api.rest_api.id}"
  resource_id = "${aws_api_gateway_method.proxy_root.resource_id}"
  http_method = "${aws_api_gateway_method.proxy_root.http_method}"

  integration_http_method = "POST"
  type                    = "AWS_PROXY"
  uri                     = "${aws_lambda_function.lambda.invoke_arn}"
}

# permit lambda to trigger APIGW
resource "aws_lambda_permission" "apigw" {
  statement_id  = "AllowAPIGatewayInvoke"
  action        = "lambda:InvokeFunction"
  function_name = "${aws_lambda_function.lambda.function_name}"
  principal     = "apigateway.amazonaws.com"

  # The /*/* portion grants access from any method on any resource
  # within the API Gateway "REST API".
  source_arn = "${aws_api_gateway_rest_api.rest_api.execution_arn}/*/*"
}