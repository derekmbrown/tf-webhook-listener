output "function_arn" {
  value = aws_lambda_function.main.arn
}

output "function_log_group_name" {
  value = aws_cloudwatch_log_group.main.name
}

output "function_name" {
  value = aws_lambda_function.main.function_name
}

output "function_url" {
  value = aws_lambda_function_url.main.function_url
}
