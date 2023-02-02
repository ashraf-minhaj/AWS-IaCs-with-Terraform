# create a role
# reseource_type - resource_name
resource "aws_iam_role" "lambdaErr_role" {
  name = "${var.component_prefix}-${var.lambdaErr_name}-lambda-role"
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
resource "aws_iam_policy" "lambdaErr_policy" {
  name = "${var.component_prefix}-${var.lambdaErr_name}-lambda-policy"
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
resource "aws_iam_role_policy_attachment" "lambdaErr_policy_attachment" {
  role       = "${aws_iam_role.lambdaErr_role.name}"
  policy_arn = "${aws_iam_policy.lambdaErr_policy.arn}"
}

# attach role to lambda on lmabda's end

# Zip the Lamda function on the fly
data "archive_file" "lamdaErr_source" {
  type              = "${var.archive_file_type}"
  source_dir        = "../lambdaErr/"
  output_path       = "../lambdaErr/lambdaErr.zip"
}

# upload zip to s3 and then update lamda function from s3
resource "aws_s3_object" "lambdaErr_object" {
  bucket            = "${aws_s3_bucket.s3_bucket.bucket}"
  key               = "${var.lambaErr_s3_key}"
  source            = data.archive_file.lamdaErr_source.output_path
  source_hash       = "${data.archive_file.lamdaErr_source.output_base64sha256}"
}

# connect this lambda with uploaded s3 zip file
# lambda needs code and iam_role
# "${aws_s3_bucket_object.file_upload.key}"
# resource - resource_name
resource "aws_lambda_function" "lambdaErr" {
    function_name     = "${var.component_prefix}-${var.lambdaErr_name}"
    source_code_hash  = "${data.archive_file.lamdaErr_source.output_base64sha256}"
    s3_bucket         = aws_s3_object.lambdaErr_object.bucket
    s3_key            = aws_s3_object.lambdaErr_object.key
    role              = aws_iam_role.lambdaErr_role.arn 
    handler           = "${var.component_prefix}-${var.lambdaErr_name}.${var.lambdaErr_handler}"
    runtime           = "${var.lambda_runtime}"
    timeout			      = "${var.lambda_timeout}"
}