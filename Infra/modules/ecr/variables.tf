variable "repository_name" {
  type        = string
  description = "Name of the ECR repository"
}

variable "image_tag_mutability" {
  type        = string
  default     = "MUTABLE" # Use "IMMUTABLE" for production
  description = "Whether image tags can be overwritten"
}

variable "scan_on_push" {
  type        = bool
  default     = true
  description = "Enable automatic vulnerability scanning on push"
}

variable "encryption_type" {
  type        = string
  default     = "AES256" # Or "KMS" for KMS encryption
  description = "Encryption type for the repository"
}

variable "lifecycle_policy" {
  type        = string
  default     = null
  description = "JSON lifecycle policy to clean up old images"
}

variable "tags" {
  type        = map(string)
  default     = {}
  description = "Resource tags"
}
