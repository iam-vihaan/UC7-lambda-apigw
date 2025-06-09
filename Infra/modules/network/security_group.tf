resource "aws_security_group" "lambda_sg" {
  name        = "${var.name_prefix}-${terraform.workspace}-lambda-sg"
  description = "Security group for Lambda functions"
  vpc_id      = aws_vpc.demo-vpc.id

  tags = merge(var.tags, {
    Name = "${var.name_prefix}-lambda-sg"
  })
}

# Default outbound rule (allow all outbound traffic)
resource "aws_security_group_rule" "lambda_egress" {
  security_group_id = aws_security_group.lambda_sg.id
  type              = "egress"
  from_port         = 0
  to_port           = 0
  protocol          = "-1" # All protocols
  cidr_blocks       = ["0.0.0.0/0"]
}

# Add custom ingress rules if needed
resource "aws_security_group_rule" "lambda_ingress" {
  for_each = { for rule in var.ingress_rules : rule.name => rule }

  security_group_id = aws_security_group.lambda_sg.id
  type              = "ingress"
  description       = each.value.description
  from_port         = each.value.from_port
  to_port           = each.value.to_port
  protocol          = each.value.protocol
  cidr_blocks       = each.value.cidr_blocks
}
