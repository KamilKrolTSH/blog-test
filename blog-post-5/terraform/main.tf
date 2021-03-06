terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 3.27"
    }
  }

  required_version = ">= 0.14.9"
}

resource "aws_cloudformation_stack" "this" {
  name = "blog-post-stack"

  template_body = <<STACK
Resources:
  ExampleTable:
    Type: AWS::DynamoDB::Table
    Properties:
      TableName: example_table
      AttributeDefinitions:
        - AttributeName: id
          AttributeType: S
      KeySchema:
        - AttributeName: id
          KeyType: HASH
      ProvisionedThroughput:
        ReadCapacityUnits: 1
        WriteCapacityUnits: 1
      StreamSpecification:
        StreamViewType: NEW_AND_OLD_IMAGES
Outputs:
  ExampleTableStreamArn:
    Description: DynamoDB example table stream ARN
    Value: !GetAtt ExampleTable.StreamArn
    Export:
      Name: ExampleTableStreamArn
STACK
}