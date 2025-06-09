resource "aws_iam_role" "lambda_exec" {
  name               = "${var.service_name}-lambda-role"
  assume_role_policy = data.aws_iam_policy_document.lambda_assume.json
}

data "aws_iam_policy_document" "lambda_assume" {
  statement {
    actions = ["sts:AssumeRole"]

    principals {
      type        = "Service"
      identifiers = ["lambda.amazonaws.com"]
    }
  }
}

# Basic Lambda execution policy (logs)
resource "aws_iam_role_policy_attachment" "lambda_basic" {
  role       = aws_iam_role.lambda_exec.name
  policy_arn = "arn:aws:iam::aws:policy/service-role/AWSLambdaBasicExecutionRole"
}

# VPC execution policy
resource "aws_iam_role_policy_attachment" "lambda_vpc" {
  role       = aws_iam_role.lambda_exec.name
  policy_arn = "arn:aws:iam::aws:policy/service-role/AWSLambdaVPCAccessExecutionRole"
}

# Add API Gateway permissions
resource "aws_iam_policy" "lambda_apigateway" {
  name        = "${var.service_name}-lambda-apigateway"
  description = "Permissions for Lambda to integrate with API Gateway"

  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Action = [
          "logs:CreateLogGroup",
          "logs:CreateLogStream",
          "logs:PutLogEvents"
        ],
        Effect   = "Allow",
        Resource = "*"
      },
      {
        Action = [
          "lambda:InvokeFunction",
          "lambda:GetFunction"
        ],
        Effect   = "Allow",
        Resource = "*"
      },
      # ECR permissions for container image pulling
      {
        Action = [
          "ecr:BatchGetImage",
          "ecr:GetDownloadUrlForLayer",
          "ecr:BatchCheckLayerAvailability"
        ],
        Effect   = "Allow",
        Resource = var.ecr_repository_arn
      },
      # ECR authorization token permission
      {
        Action = [
          "ecr:GetAuthorizationToken"
        ],
        Effect   = "Allow",
        Resource = "*"
      }
    ]
  })
}

# Enhanced CloudWatch permissions
resource "aws_iam_policy" "lambda_cloudwatch" {
  name        = "${var.service_name}-lambda-cloudwatch"
  description = "Enhanced CloudWatch permissions for Lambda"

  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Action = [
          "logs:CreateLogGroup",
          "logs:CreateLogStream",
          "logs:PutLogEvents",
          "logs:DescribeLogGroups",
          "logs:DescribeLogStreams"
        ],
        Effect   = "Allow",
        Resource = "*"
      }
    ]
  })
}

# Attach all policies to the role
resource "aws_iam_role_policy_attachment" "lambda_apigateway" {
  role       = aws_iam_role.lambda_exec.name
  policy_arn = aws_iam_policy.lambda_apigateway.arn
}

resource "aws_iam_role_policy_attachment" "lambda_cloudwatch" {
  role       = aws_iam_role.lambda_exec.name
  policy_arn = aws_iam_policy.lambda_cloudwatch.arn
}

resource "aws_iam_policy" "lambda_ecr_access" {
  name        = "${var.service_name}-lambda-ecr-access"
  description = "Allow Lambda to access ECR images"
  policy = jsonencode({
    Version = "2012-10-17",
    Statement = [
      {
        Effect   = "Allow",
        Action   = [
          "ecr:GetDownloadUrlForLayer",
          "ecr:BatchGetImage",
          "ecr:BatchCheckLayerAvailability"
        ],
        Resource = var.ecr_repository_arn
      },
      {
        Effect = "Allow",
        Action = [
          "ecr:GetAuthorizationToken"
        ],
        Resource = "*"
      }
    ]
  })
}

resource "aws_iam_role_policy_attachment" "lambda_ecr_policy_attachment" {
  role       = aws_iam_role.lambda_exec.name
  policy_arn = aws_iam_policy.lambda_ecr_access.arn
}
