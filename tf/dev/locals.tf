locals {
  # Base settings
  # account_id = var.account_id
  account_id = data.aws_caller_identity.current.account_id
  env        = "dev"
  project    = "test"
  region     = "us-east-1"
  server_endpoint = "https://api.dev.test.com"
}