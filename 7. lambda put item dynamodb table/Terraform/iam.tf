# create a role
# reseource_type - resource_name
resource "aws_iam_role" "lambda_role" {
  name = "${local.resource_component}-lambda-role"
  assume_role_policy = jsonencode({
    "Version": "2012-10-17",
    "Statement": [{
      "Action": "sts:AssumeRole",
      "Principal": {
        "Service": "lambda.amazonaws.com"
        },
      "Effect": "Allow",
      "Sid": ""
      }
    ]
  })
}

# create policy 
resource "aws_iam_policy" "policy" {
  name = "${local.resource_component}-lambda-policy"
  policy = jsonencode({
    "Version": "2012-10-17",
    "Statement": [
    {
        "Effect": "Allow",
        "Action": [
            "logs:*"
        ],
        "Resource": "arn:aws:logs:*:*:*"
    },
    {
        "Effect": "Allow",
        "Action": [
            "s3:*"
        ],
        "Resource": "arn:aws:s3:::*"
      },
      {
        "Effect": "Allow",
        "Action": [
            "dynamodb:DescribeTable",
            "dynamodb:Query",
            "dynamodb:Scan",
            "dynamodb:PutItem"
        ],
        "Resource": "arn:aws:dynamodb:*:*:*"
      }
    ]
  })
}

# attach policy to the role
resource "aws_iam_role_policy_attachment" "policy_attachment" {
  role       = "${aws_iam_role.lambda_role.name}"
  policy_arn = "${aws_iam_policy.policy.arn}"
}

# attach role to lambda on lmabda's end