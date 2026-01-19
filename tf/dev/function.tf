module "function_iam" {
  source = "../module/iam"

  env     = local.env
  project = local.project

  service = "lambda.amazonaws.com"
}

module "function" {
  source              = "../module/lambda_function"

  env     = local.env
  project = local.project

  name                = "listener"
  description         =  "Sends webhook to database"
  filename            = "${path.module}/../../functions/listener/function.zip"
  role                = module.function_iam.role_arn
}

# module "lambda_permission_test" {
#   source = "../module/lambda_permission"

#   env     = local.env
#   project = local.project

#   statement_id  = "AllowAPIGatewayInvoke"
#   action        = "lambda:InvokeFunction"
#   function_name = module.lambda_function_test.function_name
#   principal     = "apigateway.amazonaws.com"
#   source_arn    = "arn:aws:execute-api:${local.region}:${local.account_id}:${module.api_gw_test.apigw_external_id}/*/POST/webhook"
# }

module "function_permission" {
  source = "../module/lambda_permission"

  env     = local.env
  project = local.project

  statement_id  = "AllowUnauthenticatedAccess"
  action        = "lambda:InvokeFunctionUrl"
  function_name = module.function.function_name
  principal     = "lambda.amazonaws.com"
}