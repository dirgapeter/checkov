variable "tag_actions" {
  type    = set(string)
  default = ["dynamodb:GetItem", "dynamodb:Query"]
}

data "aws_iam_policy_document" "multi_doc" {
  statement {
    sid       = "Static1"
    effect    = "Allow"
    actions   = ["iam:ListPolicies"]
    resources = ["*"]
  }

  dynamic "statement" {
    for_each = var.tag_actions
    content {
      sid       = "Dynamic-${statement.value}"
      effect    = "Allow"
      actions   = [statement.value]
      resources = ["*"]
    }
  }

  statement {
    sid       = "Static2"
    effect    = "Allow"
    actions   = ["ssm:GetParameter"]
    resources = ["*"]
  }
}
