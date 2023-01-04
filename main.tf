/*
Name: IaC Buildout for Cloud Resume Challenge
Description: AWS Infrastructure Buildout
Created by: Brice Neal
*/

terraform {
  cloud {
    organization = "bn-tf"

    workspaces {
      name = "cloud-resume-challenge-tf"
    }
  }
}

# configure the provider
provider "aws" {
  region = "us-east-1"
}

## DYNAMODB
# create the dynamodb table
resource "aws_dynamodb_table" "tf_visitorcounttable" {
  name         = "tf_visitorcounttable"
  hash_key     = "record_id"
  billing_mode = "PAY_PER_REQUEST"
  attribute {
    name = "record_id"
    type = "S"
  }
}

# create the one and only item this table needs
resource "aws_dynamodb_table_item" "tf_visitorcounttable_items" {
  table_name = aws_dynamodb_table.tf_visitorcounttable.name
  hash_key   = aws_dynamodb_table.tf_visitorcounttable.hash_key
  item       = <<EOF
        {
            "record_id":{"S": "lol"},
            "record_count":{"N": "551"}
        }
    EOF
}

## LAMBDA
# create role for lambda usage
resource "aws_iam_role" "tf_LambdaDynamoDBRole" {
    name = "tf_LambdaDynamoDBRole"
    assume_role_policy = <<EOF
        {
            "Version": "2012-10-17",
            "Statement": [
                {
                    "Effect": "Allow",
                    "Principal": {
                        "Service": "lambda.amazonaws.com"
                    },
                    "Action": "sts:AssumeRole"
                }   
            ]
        }
EOF
}

# create policy for above role (to set permissions for the role)
resource "aws_iam_policy" "tf_LambdaDynamoDBPolicy" {
    name = "tf_LambdaDynamoDBPolicy"
    policy = jsonencode(
        {
    "Version": "2012-10-17",
    "Statement": [
        {
            "Effect": "Allow",
            "Action": [
                "dynamodb:BatchGetItem",
                "dynamodb:GetItem",
                "dynamodb:Query",
                "dynamodb:Scan",
                "dynamodb:BatchWriteItem",
                "dynamodb:PutItem",
                "dynamodb:UpdateItem"
            ],
            "Resource": "arn:aws:dynamodb:us-east-1:121505435355:table/tf_visitorcounttable"
        },
        {
            "Effect": "Allow",
            "Action": [
                "logs:CreateLogStream",
                "logs:PutLogEvents"
            ],
            "Resource": "arn:aws:logs:us-east-1:121505435355:*"
        },
        {
            "Effect": "Allow",
            "Action": "logs:CreateLogGroup",
            "Resource": "*"
        }
    ]
})
}

# create attachment of the role to the policy
resource "aws_iam_role_policy_attachment" "tf_LambdaDynamoDBPolicy_attachment" {
    role = aws_iam_role.tf_LambdaDynamoDBRole.name
    policy_arn = aws_iam_policy.tf_LambdaDynamoDBPolicy.arn
}