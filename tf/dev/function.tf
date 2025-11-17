module "lambda_function_iam_test" {
  source = "../module/iam"

  # Base settings
  env     = local.env
  project = local.project

  # Role settings
  service = "lambda.amazonaws.com"
}

module "lambda_function_test" {
  source              = "../module/lambda_function"

  # Base settings
  env     = local.env
  project = local.project

  # Function settings
  name                = "listener"
  description         =  "Sends webhook to database"
  filename            = "${path.module}/../functions/listener/index.zip"
  role                = module.lambda_function_iam_test.role_arn
  server_endpoint     = local.server_endpoint
  sns_topic_id        = module.sns_test.topic_id
}

module "lambda_permission_test" {
  source = "../module/lambda_permission"

  # Base settings
  env     = local.env
  project = local.project

  # Permission settings
  statement_id  = "AllowAPIGatewayInvoke"
  action        = "lambda:InvokeFunction"
  function_name = "arn:aws:lambda:${local.region}:${local.account_id}:function:test-dev-listener"
  principal     = "apigateway.amazonaws.com"
  source_arn    = "arn:aws:execute-api:${local.region}:${local.account_id}:${module.api_gw_test.apigw_external_id}/*/POST/webhook"
}