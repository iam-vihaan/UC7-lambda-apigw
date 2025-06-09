variable "name_prefix" {
  description = "Prefix for resource names"
  type        = string
  default     = "demo-lambda"

}

variable "cidr_block" {
  description = "The CIDR block for the VPC"
  type        = string
  default     = "10.0.0.0/16"
}

variable "public_subnet_cidrs" {
  description = "List of CIDR blocks for public subnets"
  type        = list(string)
  default     = ["10.0.1.0/24", "10.0.2.0/24"]
}

variable "private_subnet_cidrs" {
  description = "List of CIDR blocks for private subnets"
  type        = list(string)
  default     = ["10.0.101.0/24", "10.0.102.0/24"]
}

variable "availability_zones" {
  description = "List of availability zones"
  type        = list(string)
  default     = ["us-east-1a", "us-east-1b", "us-east-1c"]
}

variable "environment" {
  description = "The Name of the environment"
  type        = string
  default     = "Dev"
}


variable "service_name" {
  description = "The name of the service to be used in resource naming"
  type        = string
  default     = "demo-lambda-appgw"
}





variable "lambda_memory_size" {
  description = "Memory allocated to Lambda function in MB"
  type        = number
  default     = 128
}

variable "lambda_timeout" {
  description = "Timeout for Lambda function in seconds"
  type        = number
  default     = 3
}


variable "image_tag" {
  description = "Tag for the ECR image used by the Lambda function"
  type        = string
  default     = "latest"
  
}

# API Gateway Variables
variable "api_endpoint_type" {
  description = "API Gateway endpoint type (REGIONAL, EDGE, PRIVATE)"
  type        = string
  default     = "REGIONAL"
}

variable "api_stage_name" {
  description = "Name of the API Gateway stage"
  type        = string
  default     = "prod"
}

variable "api_logging_level" {
  description = "Logging level for API Gateway (OFF, ERROR, INFO)"
  type        = string
  default     = "ERROR"
}

# CloudWatch Variables
variable "cloudwatch_log_retention_days" {
  description = "Number of days to retain CloudWatch logs"
  type        = number
  default     = 7
}

# Tags
variable "tags" {
  description = "Common tags to apply to all resources"
  type        = map(string)
  default     = {}
}


variable "aws_region" {
  description = "AWS region for all resources"
  type        = string
  default     = "us-east-1"

}



variable "lambda_architectures" {
  description = "List of architectures for the Lambda function (e.g., [\"x86_64\", \"arm64\"])"
  type        = list(string)
  default     = ["x86_64"]

}


variable "lambda_environment_variables" {
  description = "Environment variables for the Lambda function"
  type        = map(string)
  default     = {}

}


variable "access_log_destination_arn" {
  description = "ARN of the CloudWatch Logs log group for access logging"
  type        = string
  default     = null
}

variable "access_log_format" {
  description = "Format string for access logs"
  type        = string
  default     = <<EOF
{ "requestId":"$context.requestId", "ip":"$context.identity.sourceIp", "caller":"$context.identity.caller", "user":"$context.identity.user", "requestTime":"$context.requestTime", "httpMethod":"$context.httpMethod", "resourcePath":"$context.resourcePath", "status":"$context.status", "protocol":"$context.protocol", "responseLength":"$context.responseLength" }
EOF
}

variable "authorizer_id" {
  description = "API Gateway authorizer ID"
  type        = string
  default     = null

}
