output "order-queue" {
  value = aws_sqs_queue.orders_queue.id
}

output "product-queue" {
  value = aws_sqs_queue.product_queue.id
}
