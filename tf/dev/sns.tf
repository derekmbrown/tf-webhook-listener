module "sns_test" {
  source = "../module/sns"

  # Base settings
  env     = local.env
  project = local.project

  # SNS settings
  name       = "notify-server"
  protocol   = "lambda"
  lambda_arn = module.lambda_function_test.function_arn
}