variable "vpc_cidr" {}
variable "vpc_name" {}
variable "environment" {}
variable "public_cidr_block" { type = list(string) }
variable "private_cidr_block" { type = list(string) }
variable "azs" { type = list(string) }
variable "owner" {}

variable "name_prefix" {
  description = "Prefix for resource names"
  type        = string
}



variable "tags" {
  description = "Additional tags for the security group"
  type        = map(string)
  default     = {}
}

variable "ingress_rules" {
  description = "List of ingress rules to add to the security group"
  type = list(object({
    name        = string
    description = string
    from_port   = number
    to_port     = number
    protocol    = string
    cidr_blocks = list(string)
  }))
  default = []
}
