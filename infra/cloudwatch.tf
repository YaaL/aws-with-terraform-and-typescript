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

resource "aws_cloudwatch_event_rule" "all_events_processor_lambda" {
  name        = "all-events-processor-lambda-rule-${var.environment}"
  description = "Capture all event and route it to all_events_processor_lambda"

  event_pattern = <<EOF
{
"source": ["aws:sqs"]
}
EOF
}

resource "aws_cloudwatch_event_target" "all_events_processor_lambda" {
  target_id = "AllEventsProcessorLambda"
  arn       = aws_lambda_function.all_events_processor_lambda.arn
  rule      = aws_cloudwatch_event_rule.all_events_processor_lambda.name
}

resource "aws_cloudwatch_event_rule" "order_event_processor_lambda" {
  name        = "order-event-processor-lambda-rule-${var.environment}"
  description = "Capture order event and route it to order_event_processor_lambda"

  event_pattern = <<EOF
{
  "detail": {"orderId": [{"prefix": ""}]}
}
EOF
}

resource "aws_cloudwatch_event_target" "order_event_processor_lambda" {
  target_id = "OrderEventProcessorLambda"
  arn       = aws_lambda_function.order_event_processor_lambda.arn
  rule      = aws_cloudwatch_event_rule.order_event_processor_lambda.name
}

resource "aws_cloudwatch_event_rule" "product_event_processor_lambda" {
  name        = "product-event-processor-lambda-rule-${var.environment}"
  description = "Capture product event and route it to product_event_processor_lambda"

  event_pattern = <<EOF
{
  "detail": {"productId": [{"prefix": ""}]}
}
EOF
}

resource "aws_cloudwatch_event_target" "product_event_processor_lambda" {
  target_id = "ProductEventProcessorLambda"
  arn       = aws_lambda_function.product_event_processor_lambda.arn
  rule      = aws_cloudwatch_event_rule.product_event_processor_lambda.name
}
