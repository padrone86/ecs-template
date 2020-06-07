#########################
# Subnets
#########################

# Public-A
resource "aws_subnet" "subnet-public-a" {
  vpc_id            = aws_vpc.vpc.id
  cidr_block        = cidrsubnet(aws_vpc.vpc.cidr_block, 8, 1)
  availability_zone = "ap-northeast-1a"

  tags = {
    Name    = "${var.product}-${terraform.workspace}-subnet-public-a"
    Product = var.product
    Env     = terraform.workspace
  }
}

# Public-C
resource "aws_subnet" "subnet-public-c" {
  vpc_id            = aws_vpc.vpc.id
  cidr_block        = cidrsubnet(aws_vpc.vpc.cidr_block, 8, 2)
  availability_zone = "ap-northeast-1c"

  tags = {
    Name    = "${var.product}-${terraform.workspace}-subnet-public-c"
    Product = var.product
    Env     = terraform.workspace
  }
}

# Private-A
resource "aws_subnet" "subnet-private-a" {
  vpc_id            = aws_vpc.vpc.id
  cidr_block        = cidrsubnet(aws_vpc.vpc.cidr_block, 8, 65)
  availability_zone = "ap-northeast-1a"

  tags = {
    Name    = "${var.product}-${terraform.workspace}-subnet-private-a"
    Product = var.product
    Env     = terraform.workspace
  }
}

# Private-C
resource "aws_subnet" "subnet-private-c" {
  vpc_id            = aws_vpc.vpc.id
  cidr_block        = cidrsubnet(aws_vpc.vpc.cidr_block, 8, 66)
  availability_zone = "ap-northeast-1c"

  tags = {
    Name    = "${var.product}-${terraform.workspace}-subnet-private-c"
    Product = var.product
    Env     = terraform.workspace
  }
}

