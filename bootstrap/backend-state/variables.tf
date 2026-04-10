variable "aws_region" {
  description = "AWS region for Terraform backend resources"
  type        = string
}

variable "state_bucket_name" {
  description = "S3 bucket name for Terraform state"
  type        = string
}

variable "lock_table_name" {
  description = "DynamoDB table name for Terraform state locking"
  type        = string
}

variable "environment" {
  description = "Environment name"
  type        = string
  default     = "dev"
}
