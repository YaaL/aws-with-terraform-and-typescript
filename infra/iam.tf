data "aws_iam_policy_document" "lambda" {
  statement {
    effect  = "Allow"
    actions = ["sts:AssumeRole"]

    principals {
      type        = "Service"
      identifiers = ["lambda.amazonaws.com"]
    }
  }
}

resource "aws_iam_role" "sqs_event_router_lambda" {
  assume_role_policy = data.aws_iam_policy_document.lambda.json
}

resource "aws_iam_role_policy_attachment" "sqs_event_router_lambda" {
  role       = aws_iam_role.sqs_event_router_lambda.name
  policy_arn = aws_iam_policy.sqs_event_router_lambda.arn
}

resource "aws_iam_policy" "sqs_event_router_lambda" {
  policy = data.aws_iam_policy_document.sqs_event_router_lambda.json
}

data "aws_iam_policy_document" "sqs_event_router_lambda" {

  statement {
    sid       = "AllowPutEventsPermissions"
    effect    = "Allow"
    resources = ["arn:aws:events:${var.region}:*:event-bus/*"]
    actions   = ["events:PutEvents"]
  }

  statement {
    sid       = "AllowSQSPermissions"
    effect    = "Allow"
    resources = ["arn:aws:sqs:*"]

    actions = [
      "sqs:ChangeMessageVisibility",
      "sqs:DeleteMessage",
      "sqs:GetQueueAttributes",
      "sqs:ReceiveMessage",
    ]
  }

  statement {
    sid       = "AllowInvokingLambdas"
    effect    = "Allow"
    resources = ["arn:aws:lambda:${var.region}:*:function:*"]
    actions   = ["lambda:InvokeFunction"]
  }

  statement {
    sid       = "AllowCreatingLogGroups"
    effect    = "Allow"
    resources = ["arn:aws:logs:${var.region}:*:*"]
    actions   = ["logs:CreateLogGroup"]
  }

  statement {
    sid       = "AllowWritingLogs"
    effect    = "Allow"
    resources = ["arn:aws:logs:${var.region}:*:log-group:/aws/lambda/*:*"]

    actions = [
      "logs:CreateLogStream",
      "logs:PutLogEvents",
    ]
  }
}

resource "aws_iam_role" "order_event_processor_lambda" {
  assume_role_policy = data.aws_iam_policy_document.lambda.json
}

resource "aws_iam_role_policy_attachment" "order_event_processor_lambda" {
  role       = aws_iam_role.order_event_processor_lambda.name
  policy_arn = aws_iam_policy.order_event_processor_lambda.arn
}

resource "aws_iam_policy" "order_event_processor_lambda" {
  policy = data.aws_iam_policy_document.order_event_processor_lambda.json
}

data "aws_iam_policy_document" "order_event_processor_lambda" {
  statement {
    sid       = "AllowCreatingLogGroups"
    effect    = "Allow"
    resources = ["arn:aws:logs:${var.region}:*:*"]
    actions   = ["logs:CreateLogGroup"]
  }

  statement {
    sid       = "AllowWritingLogs"
    effect    = "Allow"
    resources = ["arn:aws:logs:${var.region}:*:log-group:/aws/lambda/*:*"]

    actions = [
      "logs:CreateLogStream",
      "logs:PutLogEvents",
    ]
  }
}

resource "aws_iam_role" "product_event_processor_lambda" {
  assume_role_policy = data.aws_iam_policy_document.lambda.json
}

resource "aws_iam_role_policy_attachment" "product_event_processor_lambda" {
  role       = aws_iam_role.product_event_processor_lambda.name
  policy_arn = aws_iam_policy.product_event_processor_lambda.arn
}

resource "aws_iam_policy" "product_event_processor_lambda" {
  policy = data.aws_iam_policy_document.product_event_processor_lambda.json
}

data "aws_iam_policy_document" "product_event_processor_lambda" {
  statement {
    sid       = "AllowCreatingLogGroups"
    effect    = "Allow"
    resources = ["arn:aws:logs:${var.region}:*:*"]
    actions   = ["logs:CreateLogGroup"]
  }

  statement {
    sid       = "AllowWritingLogs"
    effect    = "Allow"
    resources = ["arn:aws:logs:${var.region}:*:log-group:/aws/lambda/*:*"]

    actions = [
      "logs:CreateLogStream",
      "logs:PutLogEvents",
    ]
  }
}

resource "aws_iam_role" "all_events_processor_lambda" {
  assume_role_policy = data.aws_iam_policy_document.lambda.json
}

resource "aws_iam_role_policy_attachment" "all_events_processor_lambda" {
  role       = aws_iam_role.all_events_processor_lambda.name
  policy_arn = aws_iam_policy.all_events_processor_lambda.arn
}

resource "aws_iam_policy" "all_events_processor_lambda" {
  policy = data.aws_iam_policy_document.all_events_processor_lambda.json
}

data "aws_iam_policy_document" "all_events_processor_lambda" {
  statement {
    sid       = "AllowCreatingLogGroups"
    effect    = "Allow"
    resources = ["arn:aws:logs:${var.region}:*:*"]
    actions   = ["logs:CreateLogGroup"]
  }

  statement {
    sid       = "AllowWritingLogs"
    effect    = "Allow"
    resources = ["arn:aws:logs:${var.region}:*:log-group:/aws/lambda/*:*"]

    actions = [
      "logs:CreateLogStream",
      "logs:PutLogEvents",
    ]
  }
}

resource "aws_lambda_permission" "order_event_processor_lambda" {
  statement_id   = "AllowExecutionFromCloudWatch"
  action         = "lambda:InvokeFunction"
  function_name  = aws_lambda_function.order_event_processor_lambda.function_name
  principal      = "events.amazonaws.com"
  source_account = data.aws_caller_identity.current.account_id
  source_arn     = aws_cloudwatch_event_rule.order_event_processor_lambda.arn
}

resource "aws_lambda_permission" "product_event_processor_lambda" {
  statement_id   = "AllowExecutionFromCloudWatch"
  action         = "lambda:InvokeFunction"
  function_name  = aws_lambda_function.product_event_processor_lambda.function_name
  principal      = "events.amazonaws.com"
  source_account = data.aws_caller_identity.current.account_id
  source_arn     = aws_cloudwatch_event_rule.product_event_processor_lambda.arn
}

resource "aws_lambda_permission" "all_events_processor_lambda" {
  statement_id   = "AllowExecutionFromCloudWatch"
  action         = "lambda:InvokeFunction"
  function_name  = aws_lambda_function.all_events_processor_lambda.function_name
  principal      = "events.amazonaws.com"
  source_account = data.aws_caller_identity.current.account_id
  source_arn     = aws_cloudwatch_event_rule.all_events_processor_lambda.arn
}
