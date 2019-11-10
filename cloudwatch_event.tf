# resource "aws_cloudwatch_event_target" "swap-cloudwatch-target" {
#   rule      = "${aws_cloudwatch_event_rule.swap-cloudwatch.name}"
#   arn       = "${aws_lambda_function.switch-policies-lambda.arn}"
# }

# resource "aws_cloudwatch_event_rule" "swap-cloudwatch" {
#   name        = "swap-cloudwatch"
#   schedule_expression = "rate(10 minutes)" 
# }

resource "aws_cloudwatch_event_rule" "invoke-switch-policy" {
  name        = "invoke-switch-policy"

  schedule_expression = "rate(10 minutes)" 
}

resource "aws_cloudwatch_event_target" "lambda-invoke" {
  rule      = "${aws_cloudwatch_event_rule.invoke-switch-policy.name}"
  target_id = "lambda_invoke"
  arn       = "${aws_lambda_function.test_lambda.arn}"
}

resource "aws_sns_topic" "aws_logins" {
  name = "aws-console-logins"
}

resource "aws_sns_topic_policy" "default" {
  arn    = "${aws_sns_topic.aws_logins.arn}"
  policy = "${data.aws_iam_policy_document.sns_topic_policy.json}"
}

data "aws_iam_policy_document" "sns_topic_policy" {
  statement {
    effect  = "Allow"
    actions = ["SNS:Publish"]

    principals {
      type        = "Service"
      identifiers = ["events.amazonaws.com"]
    }

    resources = ["${aws_sns_topic.aws_logins.arn}"]
  }
}