environment       = "prod"
name_prefix       = "demo-lambda"
service_name      = "demo-lambda-appgw"

aws_region        = "us-east-1"
cidr_block        = "10.2.0.0/16"

public_subnet_cidrs  = ["10.2.1.0/24", "10.2.2.0/24"]
private_subnet_cidrs = ["10.2.101.0/24", "10.2.102.0/24"]

availability_zones = ["us-east-1a", "us-east-1b", "us-east-1c"]

lambda_memory_size = 512
lambda_timeout     = 10
lambda_architectures = ["x86_64"]
image_tag          = "prod-latest"

api_stage_name     = "prod"
api_logging_level  = "ERROR"
api_endpoint_type  = "REGIONAL"

cloudwatch_log_retention_days = 30

tags = {
  Environment = "prod"
  Owner       = "team-prod"
  Project     = "LambdaApp"
  Compliance  = "Yes"
}
