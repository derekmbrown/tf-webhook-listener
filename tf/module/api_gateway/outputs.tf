output "apigw_external_id" {
  value = aws_api_gateway_rest_api.main.id
}

output "apigw_external_arn" {
  value = aws_api_gateway_rest_api.main.arn
}

output "apigw_external_invoke_url" {
  value = aws_api_gateway_stage.main.invoke_url
}

output "apigw_external_api_key" {
  value = aws_api_gateway_api_key.main.value
}

output "apigw_external_path_part" {
  value = aws_api_gateway_resource.main.path_part
}

output "apigw_log_group_name" {
  value = aws_cloudwatch_log_group.access_logs.name
}