#########################
# Security groups
#########################

# Default
resource "aws_default_security_group" "security-group-default" {
  vpc_id = "${aws_vpc.vpc.id}"

  tags {
    Name    = "${var.product}-${terraform.workspace}-security-group-default"
    Product = "${var.product}"
    Env     = "${terraform.workspace}"
  }
}

# for ALB
resource "aws_security_group" "security-group-alb" {
  name   = "${var.product}-${terraform.workspace}-security-group-alb"
  vpc_id = "${aws_vpc.vpc.id}"

  tags {
    Name    = "${var.product}-${terraform.workspace}-security-group-alb"
    Product = "${var.product}"
    Env     = "${terraform.workspace}"
  }
}

# In:	All HTTP(port 80)
resource "aws_security_group_rule" "security-group-alb-in-rule-http80" {
  security_group_id = "${aws_security_group.security-group-alb.id}"
  type              = "ingress"
  from_port         = 80
  to_port           = 80
  protocol          = "tcp"
  cidr_blocks       = ["0.0.0.0/0"]
}

# In:	All HTTP(port 8080)
resource "aws_security_group_rule" "security-group-alb-in-rule-http8080" {
  security_group_id = "${aws_security_group.security-group-alb.id}"
  type              = "ingress"
  from_port         = 8080
  to_port           = 8080
  protocol          = "tcp"
  cidr_blocks       = ["0.0.0.0/0"]
}

# In:	All HTTPS
resource "aws_security_group_rule" "security-group-alb-in-rule-https443" {
  security_group_id = "${aws_security_group.security-group-alb.id}"
  type              = "ingress"
  from_port         = 443
  to_port           = 443
  protocol          = "tcp"
  cidr_blocks       = ["0.0.0.0/0"]
}

# Out:	ALL OK
resource "aws_security_group_rule" "security-group-alb-out-rule-all" {
  security_group_id = "${aws_security_group.security-group-alb.id}"
  type              = "egress"
  from_port         = 0
  to_port           = 0
  protocol          = "-1"
  cidr_blocks       = ["0.0.0.0/0"]
}

# for Frontend
resource "aws_security_group" "security-group-front" {
  name   = "${var.product}-${terraform.workspace}-security-group-front"
  vpc_id = "${aws_vpc.vpc.id}"

  tags {
    Name    = "${var.product}-${terraform.workspace}-security-group-front"
    Product = "${var.product}"
    Env     = "${terraform.workspace}"
  }
}

# In:	ALB
resource "aws_security_group_rule" "security-group-front-in-rule-alb" {
  security_group_id        = "${aws_security_group.security-group-front.id}"
  type                     = "ingress"
  from_port                = 0
  to_port                  = 0
  protocol                 = "-1"
  source_security_group_id = "${aws_security_group.security-group-alb.id}"
}

# Out:	ALL OK
resource "aws_security_group_rule" "security-group-front-out-rule-all" {
  security_group_id = "${aws_security_group.security-group-front.id}"
  type              = "egress"
  from_port         = 0
  to_port           = 0
  protocol          = "-1"
  cidr_blocks       = ["0.0.0.0/0"]
}

# for API
resource "aws_security_group" "security-group-api" {
  name   = "${var.product}-${terraform.workspace}-security-group-api"
  vpc_id = "${aws_vpc.vpc.id}"

  tags {
    Name    = "${var.product}-${terraform.workspace}-security-group-api"
    Product = "${var.product}"
    Env     = "${terraform.workspace}"
  }
}

# In:	ALB
resource "aws_security_group_rule" "security-group-api-in-rule-alb" {
  security_group_id        = "${aws_security_group.security-group-api.id}"
  type                     = "ingress"
  from_port                = 0
  to_port                  = 0
  protocol                 = "-1"
  source_security_group_id = "${aws_security_group.security-group-alb.id}"
}

# Out:	ALL OK
resource "aws_security_group_rule" "security-group-api-out-rule-all" {
  security_group_id = "${aws_security_group.security-group-api.id}"
  type              = "egress"
  from_port         = 0
  to_port           = 0
  protocol          = "-1"
  cidr_blocks       = ["0.0.0.0/0"]
}

# for RDS
resource "aws_security_group" "security-group-rds" {
  name   = "${var.product}-${terraform.workspace}-security-group-rds"
  vpc_id = "${aws_vpc.vpc.id}"

  tags {
    Name    = "${var.product}-${terraform.workspace}-security-group-rds"
    Product = "${var.product}"
    Env     = "${terraform.workspace}"
  }
}

# In:	API / MariaDB
resource "aws_security_group_rule" "security-group-rds-in-rule-api" {
  security_group_id        = "${aws_security_group.security-group-rds.id}"
  type                     = "ingress"
  from_port                = 3306
  to_port                  = 3306
  protocol                 = "tcp"
  source_security_group_id = "${aws_security_group.security-group-api.id}"
}

# Out:	ALL OK
resource "aws_security_group_rule" "security-group-rds-out-rule-all" {
  security_group_id = "${aws_security_group.security-group-rds.id}"
  type              = "egress"
  from_port         = 0
  to_port           = 0
  protocol          = "-1"
  cidr_blocks       = ["0.0.0.0/0"]
}
