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