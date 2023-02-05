# Create an EventBridge rule
resource "aws_cloudwatch_event_rule" "MyEventRule" {
  name          = "minhaj-s3-stepFunc-event" 
  description   = "Object create events on bucket s3://${aws_s3_bucket.source_bucket.id}"
  event_pattern = <<EOF
    {
    "detail-type": [
        "Object Created"
    ],
    "source": [
        "aws.s3"
    ],
    "detail": {
        "bucket": {
        "name": ["${aws_s3_bucket.source_bucket.id}"]
        }
    }
    }
    EOF
}

# Set the step function as a target of the EventBridge rule
resource "aws_cloudwatch_event_target" "MyEventRuleTarget" {
  rule      = aws_cloudwatch_event_rule.MyEventRule.name
  arn       = aws_sfn_state_machine.step_machine.arn
  role_arn  = aws_iam_role.cwe_sfn_role.arn
}

resource "aws_iam_role" "cwe_sfn_role" {
  name               = "min-cwe_sfn_role"
  assume_role_policy = data.aws_iam_policy_document.cwe_sfn_assume_role_policy_document.json
}

data "aws_iam_policy_document" "cwe_sfn_assume_role_policy_document" {
  statement {
    actions = [
      "sts:AssumeRole"
    ]

    principals {
      type = "Service"
      identifiers = [
        "states.${var.aws_region}.amazonaws.com",
        "events.amazonaws.com"
      ]
    }
  }
}

resource "aws_iam_role_policy" "cwe_sfn_role_policy" {
  name = "min-cwe_sfn_role_policy"
  role = aws_iam_role.cwe_sfn_role.id

  policy = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Effect": "Allow",
      "Action": [
        "states:StartExecution"
      ],
      "Resource": [
        "arn:aws:states:${var.aws_region}:${data.aws_caller_identity.current.account_id}:stateMachine:minhaj-state-machine"
      ]
    }
  ]
}
EOF
}