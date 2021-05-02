resource "aws_cloudwatch_log_group" "sqs_event_router_lambda_logging" {
  name              = "/aws/lambda/${local.sqs_event_router_lambda}-${var.environment}"
  retention_in_days = var.cloudwatch_logs_retention
}

resource "aws_cloudwatch_log_group" "order_event_processor_lambda_logging" {
  name              = "/aws/lambda/${local.order_event_processor_lambda}-${var.environment}"
  retention_in_days = var.cloudwatch_logs_retention
}

resource "aws_cloudwatch_log_group" "product_event_processor_lambda_logging" {
  name              = "/aws/lambda/${local.product_event_processor_lambda}-${var.environment}"
  retention_in_days = var.cloudwatch_logs_retention
}

resource "aws_cloudwatch_log_group" "all_events_processor_lambda_logging" {
  name              = "/aws/lambda/${local.all_events_processor_lambda}-${var.environment}"
  retention_in_days = var.cloudwatch_logs_retention
}
