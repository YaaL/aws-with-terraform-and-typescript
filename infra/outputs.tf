output "order-queue" {
  value = aws_sqs_queue.orders_queue.id
}

output "product-queue" {
  value = aws_sqs_queue.product_queue.id
}

output "api-url" {
  description = "Deployment url"
  value       = aws_api_gateway_stage.api_gateway_stage.invoke_url
}
