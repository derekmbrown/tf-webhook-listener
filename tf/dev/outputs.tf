output "function_log_group_name" {
  value = module.lambda_function_test.function_log_group_name
}

output "apigw_external_id" {
  value = module.api_gw_test.apigw_external_id
}

output "apigw_external_arn" {
  value = module.api_gw_test.apigw_external_arn
}

output "apigw_external_invoke_url" {
  value = module.api_gw_test.apigw_external_invoke_url
}

output "apigw_external_api_key" {
  value = module.api_gw_test.apigw_external_api_key
  sensitive = true
}

output "apigw_log_group_name" {
  value = module.api_gw_test.apigw_log_group_name
}