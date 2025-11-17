output "function_arn" {
  value = aws_lambda_function.main.arn
}

output "function_log_group_name" {
  value = aws_cloudwatch_log_group.main.name
}
