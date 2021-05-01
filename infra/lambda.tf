locals {
  sqs_event_router_lambda        = "sqsEventsRouter"
  order_event_processor_lambda   = "orderEventProcessor"
  product_event_processor_lambda = "productEventProcessor"
  all_events_processor_lambda    = "allEventsProcessor"
}

resource "aws_lambda_function" "sqs_event_router_lambda" {
  function_name                  = "${local.sqs_event_router_lambda}-${var.environment}"
  handler                        = "${local.sqs_event_router_lambda}.handler"
  s3_bucket                      = aws_s3_bucket.sqs_event_router_lambda_bucket.bucket
  s3_key                         = aws_s3_bucket_object.sqs_event_router_lambda_bucket_object.key
  role                           = aws_iam_role.lambda_exec_role.arn
  runtime                        = var.lambda_runtime
  timeout                        = var.lambda_timeout
  memory_size                    = var.lambda_memory_size
  reserved_concurrent_executions = 1
  source_code_hash               = data.archive_file.sqs_event_router_lambda_archive.output_base64sha256

  depends_on = [
    aws_s3_bucket_object.sqs_event_router_lambda_bucket_object,
  ]
}

resource "aws_lambda_event_source_mapping" "orders_queue_event_source_mapping" {
  batch_size       = 1
  event_source_arn = aws_sqs_queue.orders_queue.arn
  enabled          = true
  function_name    = aws_lambda_function.sqs_event_router_lambda.arn
}

resource "aws_lambda_event_source_mapping" "product_queue_event_source_mapping" {
  batch_size       = 1
  event_source_arn = aws_sqs_queue.product_queue.arn
  enabled          = true
  function_name    = aws_lambda_function.sqs_event_router_lambda.arn
}

resource "aws_lambda_function" "order_event_processor_lambda" {
  function_name                  = "${local.order_event_processor_lambda}-${var.environment}"
  handler                        = "${local.order_event_processor_lambda}.handler"
  s3_bucket                      = aws_s3_bucket.order_event_processor_lambda_bucket.bucket
  s3_key                         = aws_s3_bucket_object.order_event_processor_lambda_bucket_object.key
  role                           = aws_iam_role.lambda_exec_role.arn
  runtime                        = "nodejs14.x"
  timeout                        = var.lambda_timeout
  memory_size                    = var.lambda_memory_size
  reserved_concurrent_executions = 1
  source_code_hash               = data.archive_file.order_event_processor_lambda_archive.output_base64sha256

  depends_on = [
    aws_s3_bucket_object.order_event_processor_lambda_bucket_object,
  ]
}

resource "aws_lambda_function" "product_event_processor_lambda" {
  function_name                  = "${local.product_event_processor_lambda}-${var.environment}"
  handler                        = "${local.product_event_processor_lambda}.handler"
  s3_bucket                      = aws_s3_bucket.product_event_processor_lambda_bucket.bucket
  s3_key                         = aws_s3_bucket_object.product_event_processor_lambda_bucket_object.key
  role                           = aws_iam_role.lambda_exec_role.arn
  runtime                        = var.lambda_runtime
  timeout                        = var.lambda_timeout
  memory_size                    = var.lambda_memory_size
  reserved_concurrent_executions = 1
  source_code_hash               = data.archive_file.product_event_processor_lambda_archive.output_base64sha256

  depends_on = [
    aws_s3_bucket_object.product_event_processor_lambda_bucket_object,
  ]
}

resource "aws_lambda_function" "all_events_processor_lambda" {
  function_name                  = "${local.all_events_processor_lambda}-${var.environment}"
  handler                        = "${local.all_events_processor_lambda}.handler"
  s3_bucket                      = aws_s3_bucket.all_events_processor_lambda_bucket.bucket
  s3_key                         = aws_s3_bucket_object.all_events_processor_lambda_bucket_object.key
  role                           = aws_iam_role.lambda_exec_role.arn
  runtime                        = var.lambda_runtime
  timeout                        = var.lambda_timeout
  memory_size                    = var.lambda_memory_size
  reserved_concurrent_executions = 1
  source_code_hash               = data.archive_file.all_events_processor_lambda_archive.output_base64sha256

  depends_on = [
    aws_s3_bucket_object.all_events_processor_lambda_bucket_object,
  ]
}
