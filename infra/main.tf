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

resource "aws_kinesis_stream" "data_lake" {
  name             = "data-lake-${var.environment}"
  shard_count      = 1
  retention_period = 24

  tags = {
    Environment = var.environment
  }
}
