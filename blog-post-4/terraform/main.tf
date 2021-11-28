terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 3.27"
    }
  }

  required_version = ">= 0.14.9"
}

resource "aws_dynamodb_table" "this" {
  name             = "example_table"
  billing_mode     = "PAY_PER_REQUEST"
  stream_enabled   = true
  stream_view_type = "NEW_AND_OLD_IMAGES"
  hash_key         = "id"

  attribute {
    name = "id"
    type = "S"
  }
}

resource "aws_ssm_parameter" "this" {
  name        = "/blog-post/example-table-stream-arn"
  description = "DynamoDB example table stream ARN"
  type        = "String"
  value       = aws_dynamodb_table.this.stream_arn
}
