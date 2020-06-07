#########################
# Gateway
#########################

# Internet Gateway

resource "aws_internet_gateway" "main-gw" {
  vpc_id = aws_vpc.vpc.id

  tags = {
    Name    = "${var.product}-${terraform.workspace}-main-gw"
    Product = var.product
    Env     = terraform.workspace
  }
}

