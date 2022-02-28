variable "region" {
  description = "The AWS region to use"
  default     = "eu-west-1"
  type        = string
}

variable "prefix" {
  description = "The environment prefix"
  type        = string
}

variable "cidr_block" {
  description = "The CIDR block for the VPC"
  type        = string
}

variable "dhcp_options_domain_name" {
  description = "Specifies DNS name for DHCP options set"
  type        = string
}

variable "azs" {
  description = "A list of Availabilty Zones"
  default     = ["eu-west-1a", "eu-west-1b"]
  type        = list(string)
}

variable "public_subnets" {
  description = "A list of public subnets inside the VPC"
  type        = list(string)
}

variable "private_subnets" {
  description = "A list of private subnets inside the VPC"
  type        = list(string)
}

