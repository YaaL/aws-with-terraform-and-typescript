provider "aws" {
  region = var.region
}

data "aws_caller_identity" "current" {}

resource "random_id" "id" {
  byte_length = 8
}

resource "aws_sqs_queue" "orders_queue" {
  name = "orders-queue-${var.environment}"
}

resource "aws_sqs_queue" "product_queue" {
  name = "product-queue-${var.environment}"
}
