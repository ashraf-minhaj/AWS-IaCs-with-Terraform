# create a role
# reseource_type - resource_name
resource "aws_iam_role" "lambda2_role" {
  name = "${var.component_prefix}-${var.lambda2_name}-lambda-role"
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
resource "aws_iam_policy" "lambda2_policy" {
  name = "${var.component_prefix}-${var.lambda2_name}-lambda-policy"
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
      }
    ]
  })
}

# attach policy to the role
resource "aws_iam_role_policy_attachment" "lambda2_policy_attachment" {
  role       = "${aws_iam_role.lambda2_role.name}"
  policy_arn = "${aws_iam_policy.lambda2_policy.arn}"
}

# attach role to lambda on lmabda's end

# Zip the Lamda function on the fly
data "archive_file" "lamda2_source" {
  type              = "${var.archive_file_type}"
  source_dir        = "../lambda2/"
  output_path       = "../lambda2/lambda2.zip"
}

# upload zip to s3 and then update lamda function from s3
resource "aws_s3_object" "lambda2_object" {
  bucket            = "${aws_s3_bucket.s3_bucket.bucket}"
  key               = "${var.lamba2_s3_key}"
  source            = data.archive_file.lamda2_source.output_path
}

# connect this lambda with uploaded s3 zip file
# lambda needs code and iam_role
# "${aws_s3_bucket_object.file_upload.key}"
# resource - resource_name
resource "aws_lambda_function" "lambda2" {
    function_name   = "${var.component_prefix}-${var.lambda2_name}"
    s3_bucket       = aws_s3_object.lambda2_object.bucket
    s3_key          = aws_s3_object.lambda2_object.key
    role            = aws_iam_role.lambda2_role.arn 
    handler         = "${var.component_prefix}-${var.lambda2_name}.${var.lambda2_handler}"
    runtime         = "${var.lambda_runtime}"
    timeout			    = "${var.lambda_timeout}"
}