environment       = "staging"
name_prefix       = "demo-lambda"
service_name      = "demo-lambda-appgw"

aws_region        = "ap-south-1"
cidr_block        = "10.1.0.0/16"

public_subnet_cidrs  = ["10.1.1.0/24", "10.1.2.0/24"]
private_subnet_cidrs = ["10.1.101.0/24", "10.1.102.0/24"]

availability_zones = ["ap-south-1a", "ap-south-1b", "ap-south-1c"]


lambda_memory_size = 256
lambda_timeout     = 5
lambda_architectures = ["x86_64"]
image_tag          = "staging-latest"

api_stage_name     = "staging"
api_logging_level  = "INFO"
api_endpoint_type  = "REGIONAL"

cloudwatch_log_retention_days = 14

tags = {
  Environment = "staging"
  Owner       = "team-staging"
  Project     = "LambdaApp"
}
