#########################
# Routes Table
#########################

# Default(Private)
resource "aws_default_route_table" "default-route-table" {
  default_route_table_id = "${aws_vpc.vpc.default_route_table_id}"

  tags {
    Name    = "${var.product}-${terraform.workspace}-default-route-table"
    Product = "${var.product}"
    Env     = "${terraform.workspace}"
  }
}

resource "aws_route_table_association" "route-private-a" {
  route_table_id = "${aws_default_route_table.default-route-table.id}"
  subnet_id      = "${aws_subnet.subnet-private-a.id}"
}

resource "aws_route_table_association" "route-private-c" {
  route_table_id = "${aws_default_route_table.default-route-table.id}"
  subnet_id      = "${aws_subnet.subnet-private-c.id}"
}

# Public
resource "aws_route_table" "public-route-table" {
  vpc_id = "${aws_vpc.vpc.id}"

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = "${aws_internet_gateway.main-gw.id}"
  }

  tags {
    Name    = "${var.product}-${terraform.workspace}-public-route-table"
    Product = "${var.product}"
    Env     = "${terraform.workspace}"
  }
}

resource "aws_route_table_association" "route-public-a" {
  route_table_id = "${aws_route_table.public-route-table.id}"
  subnet_id      = "${aws_subnet.subnet-public-a.id}"
}

resource "aws_route_table_association" "route-public-c" {
  route_table_id = "${aws_route_table.public-route-table.id}"
  subnet_id      = "${aws_subnet.subnet-public-c.id}"
}
