variable "aws_region" {
  type        = "string"
  default     = "eu-west-1"
  description = "AWS Region"
}

variable "environment" {
  type        = "string"
  description = "Environment Name"
}

variable "ha-nat_subnets_cidrs" {
  type        = "list"
  description = "A list of CIDR blocks to create NAT Gateways in, iterating through available availability zones"
}

variable "peering_connections" {
  type        = "list"
  default     = []
  description = "A list of peering connections to propagate to all 5 route tables"
}

variable "peer_matrix" {
  type    = "list"
  default = []
  description = "List of peering partner tuples (['peer_aws_account_id,peer_vpc_id,peer_cidr_block']) with which to create vpc peering connections"
}

variable "private_dns_domain" {
  type        = "string"
  description = "Private Hosted Zone domain name for the VPC"
}

variable "project" {
  type        = "string"
  description = "Project/Application Name"
}

variable "region_az_count" {
  type        = "string"
  default     = "3"
  description = "An ugly hack"
}

variable "vpc_cidr" {
  type        = "string"
  description = "VPC CIDR Block"
}
