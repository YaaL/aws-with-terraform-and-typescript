resource "aws_dynamodb_table" "product" {
  name         = "${var.product_table}-${var.environment}"
  billing_mode = "PAY_PER_REQUEST"
  hash_key     = "ProductId"
  range_key    = "Status"

  attribute {
    name = "ProductId"
    type = "S"
  }

  attribute {
    name = "Status"
    type = "S"
  }
}

resource "aws_dynamodb_table" "order" {
  name         = "${var.order_table}-${var.environment}"
  billing_mode = "PAY_PER_REQUEST"
  hash_key     = "OrderId"
  range_key    = "Status"

  attribute {
    name = "OrderId"
    type = "S"
  }

  attribute {
    name = "Status"
    type = "S"
  }
}
