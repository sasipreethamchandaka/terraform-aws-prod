variable "cidr_block" {
  description = "VPC CIDR"
  type        = string
  default     = "10.0.0.0/16"
}

variable "public_subnet_count" {
  description = "Number of public subnets"
  type        = number
  default     = 2
}

variable "private_subnet_count" {
  description = "Number of private subnets"
  type        = number
  default     = 2
}
