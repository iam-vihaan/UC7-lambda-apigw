module "network" {
  source             = "./modules/network"
  vpc_cidr           = var.cidr_block
  vpc_name           = "demo-lambda-appgw-vpc"
  environment        = var.environment
  public_cidr_block  = var.public_subnet_cidrs
  private_cidr_block = var.private_subnet_cidrs
  azs                = var.availability_zones
  owner              = "demo-lambda-appgw"
  name_prefix        = var.name_prefix
}

module "nat" {
  source            = "./modules/nat"
  public_subnet_ids = module.network.public_subnets_id
  private_rt_ids    = module.network.private_route_table_ids
  vpc_name          = module.network.vpc_name
}


module "lambda_iam" {
  source = "./modules/iam" # Path to your IAM module directory

  service_name = var.service_name
  #  lambda_additional_policy = var.lambda_additional_policy
  ecr_repository_arn = module.ecr.repository_arn
}


module "ecr" {
  source          = "./modules/ecr"
  repository_name = "${var.service_name}-${terraform.workspace}"
  lifecycle_policy = jsonencode({
    rules = [{
      rulePriority = 1,
      description  = "Keep last 5 images",
      action       = { type = "expire" },
      selection = {
        tagStatus   = "any",
        countType   = "imageCountMoreThan",
        countNumber = 5
      }
    }]
  })
}


module "lambda" {
  source                = "./modules/lambda"
  function_name         = "${var.service_name}-${terraform.workspace}-handler"
  role_arn              = module.lambda_iam.lambda_exec_role_arn
  image_uri             = "${module.ecr.repository_url}:${var.image_tag}" # Required for container-based Lambda
  memory_size           = var.lambda_memory_size
  timeout               = var.lambda_timeout
  architectures         = var.lambda_architectures
  environment_variables = var.lambda_environment_variables # Env Vars
  image_config = {
    command = ["app.lambda_handler"]
  }

  # VPC config (optional)
  subnet_ids         = module.network.private_subnets_id
  security_group_ids = [module.network.security_group_id]

  # Tags
  tags = var.tags
}


module "apigateway" {
  source                     = "./modules/apigw"
  api_name                   = "${var.service_name}-api"
  description                = "API Gateway for ${var.service_name}"
  aws_region                 = "us-east-1"
  endpoint_type              = var.api_endpoint_type
  lambda_function_arn        = module.lambda.function_arn
  stage_name                 = var.api_stage_name
  stage_description          = "Stage for ${var.service_name}" # <-- Add this
  logging_level              = var.api_logging_level
  authorization_type         = "NONE" # <-- or "CUSTOM" / "AWS_IAM"
  enable_cloudwatch_logging  = true   # <-- Required for CW role
  metrics_enabled            = true
  data_trace_enabled         = true
  throttling_burst_limit     = 100
  throttling_rate_limit      = 50
  access_log_destination_arn = var.access_log_destination_arn # Optional
  access_log_format          = var.access_log_format          # Optional
  authorizer_id              = var.authorizer_id              # Optional
  tags                       = var.tags
}


resource "aws_lambda_permission" "apigw" {
  statement_id  = "AllowAPIGatewayInvoke"
  action        = "lambda:InvokeFunction"
  function_name = module.lambda.function_name
  principal     = "apigateway.amazonaws.com"
  source_arn    = "${module.apigateway.execution_arn}/*/*"
}



module "cloudwatch" {
  source = "./modules/cloudwatch"

  service_name         = var.service_name
  api_name             = module.apigateway.rest_api_id
  lambda_function_name = module.lambda.function_name
  log_retention_days   = var.cloudwatch_log_retention_days
  region               = var.aws_region
  tags                 = var.tags
}
