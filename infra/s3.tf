locals {
  dist_root_dir = "${path.module}/../dist"
}

resource "aws_s3_bucket" "sqs_event_router_lambda_bucket" {
  force_destroy = var.s3_force_destroy
  acl           = "private"

  versioning {
    enabled = var.s3_versioning
  }

  lifecycle_rule {
    enabled = var.s3_versioning

    noncurrent_version_expiration {
      days = var.s3_versioning_expiration
    }
  }
}

data "archive_file" "sqs_event_router_lambda_archive" {
  type        = "zip"
  output_path = "${local.dist_root_dir}/${local.sqs_event_router_lambda}.zip"
  source_file = "${local.dist_root_dir}/${local.sqs_event_router_lambda}.js"
}

resource "aws_s3_bucket_object" "sqs_event_router_lambda_bucket_object" {
  key    = "${random_id.id.hex}-object-${var.environment}"
  bucket = aws_s3_bucket.sqs_event_router_lambda_bucket.id
  source = data.archive_file.sqs_event_router_lambda_archive.output_path
  etag   = data.archive_file.sqs_event_router_lambda_archive.output_base64sha256
}

resource "aws_s3_bucket" "order_event_processor_lambda_bucket" {
  force_destroy = var.s3_force_destroy
  acl           = "private"

  versioning {
    enabled = var.s3_versioning
  }

  lifecycle_rule {
    enabled = var.s3_versioning

    noncurrent_version_expiration {
      days = var.s3_versioning_expiration
    }
  }
}

data "archive_file" "order_event_processor_lambda_archive" {
  type        = "zip"
  output_path = "${local.dist_root_dir}/${local.order_event_processor_lambda}.zip"
  source_file = "${local.dist_root_dir}/${local.order_event_processor_lambda}.js"
}

resource "aws_s3_bucket_object" "order_event_processor_lambda_bucket_object" {
  key    = "${random_id.id.hex}-object-${var.environment}"
  bucket = aws_s3_bucket.order_event_processor_lambda_bucket.id
  source = data.archive_file.order_event_processor_lambda_archive.output_path
  etag   = data.archive_file.order_event_processor_lambda_archive.output_base64sha256
}

data "archive_file" "product_event_processor_lambda_archive" {
  type        = "zip"
  output_path = "${local.dist_root_dir}/${local.product_event_processor_lambda}.zip"
  source_file = "${local.dist_root_dir}/${local.product_event_processor_lambda}.js"
}

resource "aws_s3_bucket" "product_event_processor_lambda_bucket" {
  force_destroy = var.s3_force_destroy
  acl           = "private"

  versioning {
    enabled = var.s3_versioning
  }

  lifecycle_rule {
    enabled = var.s3_versioning

    noncurrent_version_expiration {
      days = var.s3_versioning_expiration
    }
  }
}

resource "aws_s3_bucket_object" "product_event_processor_lambda_bucket_object" {
  key    = "${random_id.id.hex}-object-${var.environment}"
  bucket = aws_s3_bucket.product_event_processor_lambda_bucket.id
  source = data.archive_file.product_event_processor_lambda_archive.output_path
  etag   = data.archive_file.product_event_processor_lambda_archive.output_base64sha256
}

resource "aws_s3_bucket" "all_events_processor_lambda_bucket" {
  force_destroy = var.s3_force_destroy
  acl           = "private"

  versioning {
    enabled = var.s3_versioning
  }

  lifecycle_rule {
    enabled = var.s3_versioning

    noncurrent_version_expiration {
      days = var.s3_versioning_expiration
    }
  }
}

data "archive_file" "all_events_processor_lambda_archive" {
  type        = "zip"
  output_path = "${local.dist_root_dir}/${local.all_events_processor_lambda}.zip"
  source_file = "${local.dist_root_dir}/${local.all_events_processor_lambda}.js"
}

resource "aws_s3_bucket_object" "all_events_processor_lambda_bucket_object" {
  key    = "${random_id.id.hex}-object-${var.environment}"
  bucket = aws_s3_bucket.all_events_processor_lambda_bucket.id
  source = data.archive_file.all_events_processor_lambda_archive.output_path
  etag   = data.archive_file.all_events_processor_lambda_archive.output_base64sha256
}
