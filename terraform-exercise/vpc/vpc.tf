module "vpc" {
  source  = "terraform-aws-modules/vpc/aws"
  version = "3.12.0"

  #name = local.name
  name = var.prefix

  cidr = var.cidr_block
  azs  = var.azs

  enable_dhcp_options      = true
  enable_dns_hostnames     = true
  dhcp_options_domain_name = var.dhcp_options_domain_name

  map_public_ip_on_launch = false

  nat_eip_tags = {
    "accessible" = "private"
  }

  igw_tags = {
    "Name" = "${var.prefix}-igw"
  }

  vpc_tags = {
    "Name" = "${var.prefix}-vpc"
  }

  dhcp_options_tags = {
    "Name" = "${var.prefix}-dhcp-options-set"
  }

  public_subnet_tags = {
    "accessible" = "public"
  }

  private_subnet_tags = {
    "accessible" = "private"
  }

  public_route_table_tags = {
    "Name"       = "${var.prefix}-public-${var.region}"
    "accessible" = "public"
  }

  private_route_table_tags = {
    "accessible" = "private"
  }
}

