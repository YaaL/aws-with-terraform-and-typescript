resource "aws_sqs_queue" "orders_queue" {
  name = "OrdersQueue"
}

resource "aws_sqs_queue" "product_queue" {
  name = "ProductQueue"
}
