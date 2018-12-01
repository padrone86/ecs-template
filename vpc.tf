#########################
# VPC
#########################

# VPC
resource "aws_vpc" "vpc" {
  cidr_block           = "10.1.0.0/16"
  enable_dns_support   = "true"
  enable_dns_hostnames = "true"

  tags = {
    "Name"    = "${var.product}-${terraform.workspace}-vpc"
    "Product" = "${var.product}"
    "Env"     = "${terraform.workspace}"
  }
}
