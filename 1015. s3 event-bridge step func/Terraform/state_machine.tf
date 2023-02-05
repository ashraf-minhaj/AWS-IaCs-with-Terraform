resource "aws_sfn_state_machine" "step_machine" {
  name        = "${var.component_prefix}-${var.step_function_name}"
  role_arn    = aws_iam_role.step_function_role.arn

  definition  = jsonencode(
    {
      "Comment": "Invoke AWS Lambda from AWS Step Functions with Terraform",
      "StartAt": "function1",
      "States": {
        "function1": {
          "Type": "Task",
          "Resource": "${aws_lambda_function.lambda1.arn}",
          "Next": "function2"
          "Catch": [ {
            "ErrorEquals": [ "States.ALL" ],
            "Next": "lambdaErr"
          } ]
        },
        "function2": {
          "Type": "Task",
          "Resource": "${aws_lambda_function.lambda2.arn}",
          "Catch": [ {
            "ErrorEquals": [ "States.ALL" ],
            "Next": "lambdaErr"
          } ],
          "End": true
        },
        "lambdaErr": {
          "Type": "Task",
          "Resource": "${aws_lambda_function.lambdaErr.arn}",
          "End": true
        }
      #   "Catch": [ {
      #   "ErrorEquals": [ "States.ALL" ],
      #   "Next": "lambdaErr"
      # } ]
      }
    }
  )


}

resource "aws_iam_role" "step_function_role" {
  name               = "${var.component_prefix}-${var.step_function_name}-role"
  assume_role_policy = jsonencode(
  {
    "Version": "2012-10-17",
    "Statement": [
      {
        "Action": "sts:AssumeRole",
        "Principal": {
          "Service": "states.amazonaws.com"
        },
        "Effect": "Allow",
        "Sid": "StepFunctionAssumeRole"
      }
    ]
  }
  )
}

resource "aws_iam_role_policy" "step_function_policy" {
  name    = "${var.component_prefix}-${var.step_function_name}-policy"
  role    = aws_iam_role.step_function_role.id

  policy  = jsonencode(
  {
    "Version": "2012-10-17",
    "Statement": [
      {
        "Action": [
          "lambda:InvokeFunction"
        ],
        "Effect": "Allow",
        "Resource" : "*"
        # "Resource": "${aws_lambda_function.lambda_function.arn}"
      }
    ]
  }
  )
}