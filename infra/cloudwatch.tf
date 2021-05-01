resource "aws_cloudwatch_log_group" "sqs_event_router_lambda_logging" {
  name              = "/aws/lambda/${local.sqs_event_router_lambda}"
  retention_in_days = var.cloudwatch_logs_retention
}

data "aws_iam_policy_document" "sqs_event_router_function_policy_document" {
  statement {
    effect = "Allow"

    actions = [
      "logs:CreateLogStream",
      "logs:CreateLogGroup",
    ]

    resources = [aws_cloudwatch_log_group.sqs_event_router_lambda_logging.arn]
  }

  statement {
    effect    = "Allow"
    actions   = ["logs:PutLogEvents"]
    resources = ["${aws_cloudwatch_log_group.sqs_event_router_lambda_logging.arn}:*"]
  }
}

resource "aws_cloudwatch_log_group" "order_event_processor_lambda_logging" {
  name              = "/aws/lambda/${local.order_event_processor_lambda}"
  retention_in_days = var.cloudwatch_logs_retention
}

data "aws_iam_policy_document" "order_event_processor_function_policy_document" {
  statement {
    effect = "Allow"

    actions = [
      "logs:CreateLogStream",
      "logs:CreateLogGroup",
    ]

    resources = [aws_cloudwatch_log_group.order_event_processor_lambda_logging.arn]
  }

  statement {
    effect    = "Allow"
    actions   = ["logs:PutLogEvents"]
    resources = ["${aws_cloudwatch_log_group.order_event_processor_lambda_logging.arn}:*"]
  }
}

resource "aws_cloudwatch_log_group" "product_event_processor_lambda_logging" {
  name              = "/aws/lambda/${local.product_event_processor_lambda}"
  retention_in_days = var.cloudwatch_logs_retention
}

data "aws_iam_policy_document" "product_event_processor_lambda_policy_document" {
  statement {
    effect = "Allow"

    actions = [
      "logs:CreateLogStream",
      "logs:CreateLogGroup",
    ]

    resources = [aws_cloudwatch_log_group.product_event_processor_lambda_logging.arn]
  }

  statement {
    effect    = "Allow"
    actions   = ["logs:PutLogEvents"]
    resources = ["${aws_cloudwatch_log_group.product_event_processor_lambda_logging.arn}:*"]
  }
}

resource "aws_cloudwatch_log_group" "all_events_processor_lambda_logging" {
  name              = "/aws/lambda/${local.all_events_processor_lambda}"
  retention_in_days = var.cloudwatch_logs_retention
}

data "aws_iam_policy_document" "all_events_processor_lambda_policy_document" {
  statement {
    effect = "Allow"

    actions = [
      "logs:CreateLogStream",
      "logs:CreateLogGroup",
    ]

    resources = [aws_cloudwatch_log_group.all_events_processor_lambda_logging.arn]
  }

  statement {
    effect    = "Allow"
    actions   = ["logs:PutLogEvents"]
    resources = ["${aws_cloudwatch_log_group.all_events_processor_lambda_logging.arn}:*"]
  }
}
