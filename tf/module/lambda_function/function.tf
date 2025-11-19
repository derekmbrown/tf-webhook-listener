resource "aws_lambda_function" "main" {
  function_name = "${var.project}-${var.env}-${var.name}"
  description   = var.description
  filename      = var.filename
  role          = var.role
  handler       = var.handler
  runtime       = var.runtime
  publish       = var.publish
  timeout       = var.timeout

  environment {
    variables = {
      ENV             = var.env
    }
  }

  tags = {
    Env     = var.env
    Project = var.project
  }
}
