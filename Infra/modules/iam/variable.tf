variable "service_name" {
  description = "Name of the service for resource naming"
  type        = string
}

# variable "lambda_additional_policy" {
#   description = "Additional IAM policy document for Lambda function"
#   type        = string
#   default     = "{}"
# }

variable "ecr_repository_arn" {
  description = "ARN of the ECR repository"
  type        = string
}
