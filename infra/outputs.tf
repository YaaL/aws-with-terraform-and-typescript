output "OrderQueue" {
  value = aws_sqs_queue.orders_queue.id
}

output "ProductQueue" {
  value = aws_sqs_queue.product_queue.id
}
