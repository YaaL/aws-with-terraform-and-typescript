resource "aws_dynamodb_table" "events" {
  name         = "${var.events_table}-${var.environment}"
  billing_mode = "PAY_PER_REQUEST"
  hash_key     = "Id"

  attribute {
    name = "Id"
    type = "S"
  }

  point_in_time_recovery {
    enabled = true
  }

  server_side_encryption {
    enabled = true
  }

  ttl {
    attribute_name = "ttl"
    enabled        = true
  }
}

resource "aws_dynamodb_table" "products" {
  name         = "${var.products_table}-${var.environment}"
  billing_mode = "PAY_PER_REQUEST"
  hash_key     = "Id"

  attribute {
    name = "Id"
    type = "S"
  }

  attribute {
    name = "CategoryId"
    type = "S"
  }

  attribute {
    name = "ProductRating"
    type = "N"
  }
  global_secondary_index {
    name            = "ProductCategoryRatingIndex"
    hash_key        = "CategoryId"
    range_key       = "ProductRating"
    projection_type = "ALL"
  }

  point_in_time_recovery {
    enabled = true
  }

  server_side_encryption {
    enabled = true
  }
}

resource "aws_dynamodb_table" "orders" {
  name         = "${var.orders_table}-${var.environment}"
  billing_mode = "PAY_PER_REQUEST"
  hash_key     = "Id"
  range_key    = "Status"

  attribute {
    name = "Id"
    type = "S"
  }

  attribute {
    name = "Status"
    type = "S"
  }

  point_in_time_recovery {
    enabled = true
  }

  server_side_encryption {
    enabled = true
  }
}
