locals {
  create_trail = true
  create_pass  = true
  create_fail  = false
}

# count uses AND of two bool locals — both true → should expand to 1 resource
resource "aws_cloudtrail" "pass" {
  count                         = local.create_trail == true && local.create_pass ? 1 : 0
  name                          = "pass-trail"
  enable_log_file_validation    = true
  s3_bucket_name                = "my-bucket"
}

# create_trail=true AND create_fail=false → should expand to 0 resources
resource "aws_cloudtrail" "fail" {
  count                         = local.create_trail == true && local.create_fail ? 1 : 0
  name                          = "fail-trail"
  enable_log_file_validation    = false
  s3_bucket_name                = "my-bucket"
}

# Single bool local — should still expand to 1 resource (baseline / sanity check)
resource "aws_cloudtrail" "single_local" {
  count                         = local.create_trail == true ? 1 : 0
  name                          = "single-trail"
  enable_log_file_validation    = true
  s3_bucket_name                = "my-bucket"
}
