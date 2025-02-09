# Automatically zip the Lambda code from the ../app directory
resource "archive_file" "lambda_zip" {
  type        = "zip"
  source_dir  = "../app"
  output_path = "../app/lambda_function.zip"
}

resource "aws_lambda_function" "my_lambda" {
  function_name = "my-test-lambda"
  role          = aws_iam_role.lambda_exec.arn
  handler       = "lambda_function.lambda_handler"
  runtime       = "python3.8"
  
  # Specify the location of the Lambda function code (the zip file)
  filename      = "../app/lambda_function.zip"
#   source_code_hash = filebase64sha256("../app/lambda_function.zip")
}

resource "aws_iam_role" "lambda_exec" {
  name               = "lambda_exec_role"
  assume_role_policy = data.aws_iam_policy_document.lambda_assume_role_policy.json
}

data "aws_iam_policy_document" "lambda_assume_role_policy" {
  statement {
    actions   = ["sts:AssumeRole"]
    principals {
      type        = "Service"
      identifiers = ["lambda.amazonaws.com"]
    }
  }
}