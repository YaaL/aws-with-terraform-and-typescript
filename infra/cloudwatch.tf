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

resource "aws_cloudwatch_event_rule" "order_event_processor" {
  name        = "order-event-processor-rule-${var.environment}"
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
  rule      = aws_cloudwatch_event_rule.order_event_processor.name
}

resource "aws_cloudwatch_event_target" "order_event_processor_kinesis" {
  target_id = "OrderEventProcessorKinesis"
  arn       = aws_kinesis_stream.data_lake.arn
  rule      = aws_cloudwatch_event_rule.order_event_processor.name
  role_arn  = aws_iam_role.order_event_processor_rule.arn
}

resource "aws_cloudwatch_event_rule" "product_event_processor" {
  name        = "product-event-processor-rule-${var.environment}"
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
  rule      = aws_cloudwatch_event_rule.product_event_processor.name
}

resource "aws_cloudwatch_event_target" "product_event_processor_kinesis" {
  target_id = "ProductEventProcessorKinesis"
  arn       = aws_kinesis_stream.data_lake.arn
  rule      = aws_cloudwatch_event_rule.product_event_processor.name
  role_arn  = aws_iam_role.product_event_processor_rule.arn
}
