provider "aws" {
  region = var.region
}

data "aws_caller_identity" "current" {}

resource "random_id" "id" {
  byte_length = 8
}

resource "aws_sqs_queue" "orders_queue" {
  name = "OrdersQueue"
}

resource "aws_sqs_queue" "product_queue" {
  name = "ProductQueue"
}
