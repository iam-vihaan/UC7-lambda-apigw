output "lambda_exec_role_name" {
  value = aws_iam_role.lambda_exec.name
}

# Output the role ARN for use in Lambda module
output "lambda_exec_role_arn" {
  description = "ARN of the Lambda execution role"
  value       = aws_iam_role.lambda_exec.arn
} 
