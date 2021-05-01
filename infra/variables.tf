variable "environment" {}
variable "owner" {}
variable "region" {}
variable "lambda_runtime" {}
variable "lambda_timeout" {}
variable "lambda_memory_size" {}
variable "s3_force_destroy" {}
variable "s3_versioning" {}
variable "s3_versioning_expiration" {}
variable "cloudwatch_logs_retention" {}
variable "tags" {
  type = object({
    Owner       = string
    Environment = string
    ManagedBy   = string
  })
}
