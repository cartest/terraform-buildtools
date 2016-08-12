variable "aws_account_id" {
  type        = "string"
  default     = "000000000000"
  description = "AWS Account ID"
}

variable "aws_region" {
  type        = "string"
  default     = "eu-west-1"
  description = "AWS Region"
}

variable "environment" {
  type        = "string"
  default     = "ENVIRONMENT"
  description = "Environment Name"
}

variable "peer_matrix" {
  type        = "list"
  default     = [
    "0123456789012,vpc-01234567890123456,10.99.0.0/16",
    "2109876543210,vpc-65432109876543210,172.16.0.0/16"
  ]
  description = "List of peering partner tuples (['peer_aws_account_id,peer_vpc_id,peer_cidr_block']) with which to create vpc peering connections"
}

variable "private_dns_domain" {
  type        = "string"
  default     = "environment.project.platform.client"
  description = "Private Hosted Zone domain name for the VPC"
}

variable "project" {
  type        = "string"
  default     = "PROJECT"
  description = "Project/Application Name"
}

variable "region_az_count" {
  type        = "string"
  default     = "3"
  description = "An ugly hack"
}

variable "vpc_cidr" {
  type        = "string"
  default     = "10.0.0.0/16"
  description = "VPC CIDR Block"
}
