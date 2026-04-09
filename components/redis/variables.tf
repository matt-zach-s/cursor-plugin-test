variable "name_prefix" {
  description = "Prefix for resource names"
  type        = string
}

variable "node_type" {
  description = "ElastiCache node type"
  type        = string
}

variable "engine_version" {
  description = "Redis engine version"
  type        = string
  default     = "7.0"
}

variable "vpc_id" {
  description = "VPC ID"
  type        = string
}

variable "private_subnet_ids" {
  description = "List of private subnet IDs"
  type        = list(string)
}
