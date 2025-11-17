resource "aws_cloudwatch_log_group" "main" {
  name              = "/aws/lambda/${aws_lambda_function.main.function_name}"
  retention_in_days = var.retention_in_days

  tags = {
    Env     = var.env
    Project = var.project
  }
}
