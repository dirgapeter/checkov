variable "tokenization_enabled_true" {
  type    = bool
  default = true
}

variable "tokenization_enabled_false" {
  type    = bool
  default = false
}

data "aws_iam_policy_document" "fail_dynamic_true" {
  statement {
    effect    = "Allow"
    actions   = ["iam:ListPolicies"]
    resources = ["*"]
  }

  dynamic "statement" {
    for_each = var.tokenization_enabled_true ? toset(["placeholder"]) : toset([])
    content {
      effect    = "Allow"
      actions   = ["*"]
      resources = ["*"]
    }
  }
}

data "aws_iam_policy_document" "pass_dynamic_false" {
  statement {
    effect    = "Allow"
    actions   = ["iam:ListPolicies"]
    resources = ["*"]
  }

  dynamic "statement" {
    for_each = var.tokenization_enabled_false ? toset(["placeholder"]) : toset([])
    content {
      effect    = "Allow"
      actions   = ["*"]
      resources = ["*"]
    }
  }
}
