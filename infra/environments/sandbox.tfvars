
environment        = "sandbox"
owner              = "beautypie"
region             = "eu-west-2"
lambda_runtime     = "nodejs14.x"
lambda_timeout     = 30
lambda_memory_size = 128
s3_force_destroy   = true
s3_versioning      = true
s3_versioning_expiration = 1
cloudwatch_logs_retention = 14
products_table = "products"
orders_table = "orders"
events_table = "events"

tags = {
  Owner       = "BeautyPie"
  Environment = "sandbox"
  ManagedBy   = "Terraform"
}
