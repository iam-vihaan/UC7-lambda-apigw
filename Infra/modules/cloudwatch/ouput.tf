output "api_gateway_log_group_name" {
  value = aws_cloudwatch_log_group.api_gateway.name
}

output "lambda_log_group_name" {
  value = aws_cloudwatch_log_group.lambda.name
}

output "dashboard_arn" {
  value = aws_cloudwatch_dashboard.main.dashboard_arn
}
