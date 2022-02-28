variable "region" {
  description = "The AWS region to use"
  default     = "eu-west-1"
  type        = string
}

variable "prefix" {
  description = "The environment prefix"
  type        = string
}

variable "azs" {
  description = "A list of Availabilty Zones"
  default     = ["eu-west-1a", "eu-west-1b"]
  type        = list(string)
}

variable "rds" {
  description = "Map of variables used to provision RDS instance"
  type = map(string)
}

variable "rds_username" {
  description = "Map of variables used to provision RDS instance"
  type = string
}

variable "rds_password" {
  description = "Map of variables used to provision RDS instance"
  type = string
}

variable "ec2" {
  description = "Map of variables used to provision EC2 Stack"
  type = map(string)
}
