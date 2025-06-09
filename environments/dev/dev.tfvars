environment       = "dev"
name_prefix       = "demo-lambda"
service_name      = "demo-lambda-appgw"

aws_region        = "us-east-1"
cidr_block        = "10.0.0.0/16"

public_subnet_cidrs  = ["10.0.1.0/24", "10.0.2.0/24"]
private_subnet_cidrs = ["10.0.101.0/24", "10.0.102.0/24"]

availability_zones = ["us-east-1a", "us-east-1b", "us-east-1c"]

lambda_memory_size = 128
lambda_timeout     = 3
lambda_architectures = ["x86_64"]
image_tag          = "dev-latest"

api_stage_name     = "dev"
api_logging_level  = "INFO"
api_endpoint_type  = "REGIONAL"

cloudwatch_log_retention_days = 7

tags = {
  Environment = "dev"
  Owner       = "team-dev"
  Project     = "LambdaApp"
}
