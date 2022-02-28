terraform {
  required_version = ">= 1"
  required_providers {
    aws = {
      version = "~> 4.1.0"
    }
  }
}

provider "aws" {
  region = var.region
}

