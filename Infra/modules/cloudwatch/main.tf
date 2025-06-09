resource "aws_cloudwatch_log_group" "api_gateway" {
  name              = "/aws/apigateway/${var.api_name}"
  retention_in_days = var.log_retention_days
  tags              = var.tags
}

resource "aws_cloudwatch_log_group" "lambda" {
  name              = "/aws/lambda/${var.lambda_function_name}"
  retention_in_days = var.log_retention_days
  tags              = var.tags
}

resource "aws_cloudwatch_dashboard" "main" {
  dashboard_name = "${var.service_name}-dashboard"
  dashboard_body = jsonencode({
    widgets = [
      {
        type   = "metric"
        x      = 0
        y      = 0
        width  = 12
        height = 6
        properties = {
          metrics = [
            [
              "AWS/ApiGateway",
              "4XXError",
              "ApiName",
              var.api_name
            ],
            [
              "AWS/ApiGateway",
              "5XXError",
              "ApiName",
              var.api_name
            ]
          ]
          period = 300
          stat   = "Sum"
          region = var.region
          title  = "API Gateway Errors"
        }
      },
      {
        type   = "metric"
        x      = 12
        y      = 0
        width  = 12
        height = 6
        properties = {
          metrics = [
            [
              "AWS/Lambda",
              "Errors",
              "FunctionName",
              var.lambda_function_name
            ],
            [
              "AWS/Lambda",
              "Throttles",
              "FunctionName",
              var.lambda_function_name
            ]
          ]
          period = 300
          stat   = "Sum"
          region = var.region
          title  = "Lambda Errors/Throttles"
        }
      }
    ]
  })
}
