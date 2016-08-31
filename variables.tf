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
  /*default     = ["10.222.1.0/24", "10.222.2.0/24", "10.222.3.0/24"]*/
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
  #   "0123456789012,vpc-01234567890123456,10.99.0.0/16",
  #   "2109876543210,vpc-65432109876543210,172.16.0.0/16"
  # ]
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
  /*default     = "10.222.0.0/16"*/
  description = "VPC CIDR Block"
}
