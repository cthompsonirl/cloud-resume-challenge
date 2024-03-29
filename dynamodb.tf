# DynamoDB table creation
resource "aws_dynamodb_table" "dynamodb_table" {
  name         = "cloud-resume-visitors"
  billing_mode = "PAY_PER_REQUEST"
  hash_key     = "count"

  attribute {
    name = "count"
    type = "S"
  }
}

#Could potentially remove this and refactor to set up in lambda instead so View_Count isn't reset with reach apply

resource "aws_dynamodb_table_item" "counter" {
  table_name = aws_dynamodb_table.dynamodb_table.name
  hash_key   = aws_dynamodb_table.dynamodb_table.hash_key

  item = <<ITEM
  {
    "count": {"S": "view-count"},
    "View_Count": {"N": "0"}
  }
  ITEM
}