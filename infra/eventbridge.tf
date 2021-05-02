resource "aws_cloudwatch_event_rule" "all_events_processor_lambda" {
  name        = "all-events-processor-lambda-rule-${var.environment}"
  description = "Capture all event and route it to all_events_processor_lambda"

  event_pattern = <<EOF
{
"source": ["aws:sqs"]
}
EOF
}

resource "aws_cloudwatch_event_rule" "order_event_processor_lambda" {
  name        = "order-event-processor-lambda-rule-${var.environment}"
  description = "Capture order event and route it to order_event_processor_lambda"

  event_pattern = <<EOF
{
  "detail-type": ["OrdersQueue"]
}
EOF
}

resource "aws_cloudwatch_event_rule" "product_event_processor_lambda" {
  name        = "product-event-processor-lambda-rule-${var.environment}"
  description = "Capture product event and route it to product_event_processor_lambda"

  event_pattern = <<EOF
{
  "detail-type": ["ProductQueue"]
}
EOF
}
