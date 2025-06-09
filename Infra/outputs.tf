
output "vpc_id" {
  value = module.network.vpc_id
}

output "public_subnet_ids" {
  value = module.network.public_subnets_id
}

output "private_subnet_ids" {
  value = module.network.private_subnets_id
}


# IAM Outputs
output "lambda_execution_role_arn" {
  description = "ARN of the Lambda execution role"
  value       = module.lambda_iam.lambda_exec_role_arn
}

# ECR Outputs
output "ecr_repository_url" {
  description = "URL of the ECR repository"
  value       = module.ecr.repository_url
}

output "ecr_repository_arn" {
  description = "ARN of the ECR repository"
  value       = module.ecr.repository_arn
}

# Lambda Outputs
output "lambda_function_arn" {
  description = "ARN of the Lambda function"
  value       = module.lambda.function_arn
}

output "lambda_function_name" {
  description = "Name of the Lambda function"
  value       = module.lambda.function_name
}

output "lambda_invoke_arn" {
  description = "Invoke ARN of the Lambda function"
  value       = module.lambda.invoke_arn
}

# API Gateway Outputs
output "api_gateway_id" {
  description = "ID of the API Gateway"
  value       = module.apigateway.rest_api_id
}

output "api_gateway_execution_arn" {
  description = "Execution ARN of the API Gateway"
  value       = module.apigateway.execution_arn
}

output "api_gateway_invoke_url" {
  description = "Invoke URL of the API Gateway"
  value       = module.apigateway.invoke_url
}

output "api_gateway_stage_name" {
  description = "Name of the API Gateway stage"
  value       = module.apigateway.stage_name
}

# CloudWatch Outputs
output "api_gateway_log_group_name" {
  description = "Name of the API Gateway CloudWatch log group"
  value       = module.cloudwatch.api_gateway_log_group_name
}

output "lambda_log_group_name" {
  description = "Name of the Lambda function CloudWatch log group"
  value       = module.cloudwatch.lambda_log_group_name
}

output "cloudwatch_dashboard_arn" {
  description = "ARN of the CloudWatch dashboard"
  value       = module.cloudwatch.dashboard_arn
}

# Combined Outputs
output "base_url" {
  description = "Base URL for API Gateway"
  value       = module.apigateway.invoke_url
}
