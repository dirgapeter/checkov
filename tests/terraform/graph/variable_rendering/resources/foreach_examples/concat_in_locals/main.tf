locals {
  fail = concat([
    "mail1",
    "mail2"
  ], ["mail3"])
}

resource "aws_sns_topic_subscription" "fail" {
  for_each = toset(local.fail)

  topic_arn = "arn:aws:sns:us-east-1:123456789012:topic"
  protocol  = "email"
  endpoint  = each.value
}
