# External (public) endpoint
resource "aws_api_gateway_rest_api" "main" {
  name = "${var.project}-${var.env}"

  endpoint_configuration {
    types = ["REGIONAL"]
  }

  policy = jsonencode({
    "Version": "2012-10-17",
    "Statement": [{
      "Sid": "AllowAPIAccess",
      "Effect": "Allow",
      "Principal": "*",
      "Action": "execute-api:Invoke",
      "Resource": "*"
    }]
  })

  tags = {
    Env  = var.env
  }
}

resource "aws_api_gateway_stage" "main" {
  stage_name    = var.env
  rest_api_id   = aws_api_gateway_rest_api.main.id
  deployment_id = aws_api_gateway_deployment.main.id

  access_log_settings {
    destination_arn = aws_cloudwatch_log_group.access_logs.arn
    format          = jsonencode({ requestId = "$context.requestId" })
  }
}

resource "aws_api_gateway_deployment" "main" {
  rest_api_id = aws_api_gateway_rest_api.main.id
  depends_on  = [aws_api_gateway_method.main, aws_api_gateway_integration.main]

  lifecycle {
    create_before_destroy = true
  }
}

resource "aws_api_gateway_resource" "main" {
  rest_api_id = aws_api_gateway_rest_api.main.id
  parent_id   = aws_api_gateway_rest_api.main.root_resource_id
  path_part   = "webhook"
}

resource "aws_api_gateway_method" "main" {
  rest_api_id      = aws_api_gateway_rest_api.main.id
  resource_id      = aws_api_gateway_resource.main.id
  http_method      = "POST"
  authorization    = "NONE"
  api_key_required = true
}

resource "aws_api_gateway_method_response" "main" {
  rest_api_id = aws_api_gateway_rest_api.main.id
  resource_id = aws_api_gateway_resource.main.id
  http_method = aws_api_gateway_method.main.http_method
  status_code = "200"
}

resource "aws_api_gateway_method_settings" "main" {
  rest_api_id = aws_api_gateway_rest_api.main.id
  stage_name  = var.env
  method_path = "${aws_api_gateway_resource.main.path_part}/${aws_api_gateway_method.main.http_method}"

  settings {
    metrics_enabled = true
    logging_level   = "INFO"
  }

  depends_on = [aws_api_gateway_deployment.main]
}

resource "aws_api_gateway_integration" "main" {
  rest_api_id             = aws_api_gateway_rest_api.main.id
  resource_id             = aws_api_gateway_resource.main.id
  http_method             = aws_api_gateway_method.main.http_method
  integration_http_method = "POST"
  type                    = "AWS_PROXY"
  uri                     = var.external_uri
}

resource "aws_api_gateway_integration_response" "main" {
  rest_api_id = aws_api_gateway_rest_api.main.id
  resource_id = aws_api_gateway_resource.main.id
  http_method = aws_api_gateway_method.main.http_method
  status_code = aws_api_gateway_method_response.main.status_code
  depends_on  = [aws_api_gateway_integration.main]
}

resource "aws_api_gateway_api_key" "main" {
  name = "${var.project}-${var.env}-key"
}

resource "aws_api_gateway_usage_plan" "main" {
  name = "${var.project}-${var.env}-usage-plan"

  api_stages {
    api_id = aws_api_gateway_rest_api.main.id
    stage  = aws_api_gateway_stage.main.stage_name
  }
}

resource "aws_api_gateway_usage_plan_key" "main" {
  key_id        = aws_api_gateway_api_key.main.id
  key_type      = "API_KEY"
  usage_plan_id = aws_api_gateway_usage_plan.main.id
}

resource "aws_cloudwatch_log_group" "access_logs" {
  name              = "/aws/apigateway/${var.project}-${var.env}-access-logs"
  retention_in_days = 3

  tags = {
    Env     = var.env
    Project = var.project
  }
}

# Global role
resource "aws_iam_role" "apigw_cloudwatch" {
  name = "${var.project}-${var.env}-api-gateway-cloudwatch"

  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [{
      Effect = "Allow"
      Principal = { Service = "apigateway.amazonaws.com" }
      Action = "sts:AssumeRole"
    }]
  })
}

resource "aws_iam_role_policy_attachment" "apigw_cloudwatch" {
  role       = aws_iam_role.apigw_cloudwatch.name
  policy_arn = "arn:aws:iam::aws:policy/CloudWatchLogsFullAccess"
}

resource "aws_api_gateway_account" "account" {
  cloudwatch_role_arn = aws_iam_role.apigw_cloudwatch.arn

  depends_on = [aws_iam_role_policy_attachment.apigw_cloudwatch]
}
