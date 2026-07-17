variable "tokenization_enabled_true" {
  type    = bool
  default = true
}

variable "tokenization_enabled_false" {
  type    = bool
  default = false
}

data "aws_iam_policy_document" "mixed_true" {
  statement {
    sid = "ListSSCSpecificPolicies"

    effect = "Allow"
    actions = [
      "iam:ListPolicies",
      "iam:GetPolicy",
    ]
    resources = ["*"]
  }

  dynamic "statement" {
    for_each = var.tokenization_enabled_true ? toset(["placeholder"]) : toset([])
    content {
      sid       = "AllowTokenizationTagReading"
      effect    = "Allow"
      actions   = ["dynamodb:GetItem"]
      resources = ["*"]
    }
  }

  statement {
    sid = "AllowRetrievePoliciesFromSSM"

    effect = "Allow"
    actions = [
      "ssm:GetParameter",
    ]
    resources = ["*"]
  }
}

data "aws_iam_policy_document" "mixed_false" {
  statement {
    sid = "ListSSCSpecificPolicies"

    effect = "Allow"
    actions = [
      "iam:ListPolicies",
      "iam:GetPolicy",
    ]
    resources = ["*"]
  }

  dynamic "statement" {
    for_each = var.tokenization_enabled_false ? toset(["placeholder"]) : toset([])
    content {
      sid       = "AllowTokenizationTagReading"
      effect    = "Allow"
      actions   = ["dynamodb:GetItem"]
      resources = ["*"]
    }
  }

  statement {
    sid = "AllowRetrievePoliciesFromSSM"

    effect = "Allow"
    actions = [
      "ssm:GetParameter",
    ]
    resources = ["*"]
  }
}
