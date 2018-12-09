#########################
# RDS
#########################

# Subnet group

resource "aws_db_subnet_group" "rds-subnet-group" {
  name       = "${var.product}-${terraform.workspace}-rds-subnet-group"
  subnet_ids = ["${aws_subnet.subnet-private-a.id}", "${aws_subnet.subnet-private-c.id}"]
}

# Parameter group

resource "aws_db_parameter_group" "rds-params" {
  name   = "${var.product}-${terraform.workspace}-rds-params"
  family = "mariadb10.2"
}

# Write DB

resource "aws_db_instance" "rds" {
  identifier              = "${var.product}-${terraform.workspace}-rds"
  allocated_storage       = "${var.db_storage}"
  storage_type            = "gp2"
  engine                  = "mariadb"
  engine_version          = "10.2.15"
  instance_class          = "db.t2.micro"
  name                    = "${var.db_name}"
  username                = "${var.db_user}"
  password                = "${var.db_pass}"
  parameter_group_name    = "${aws_db_parameter_group.rds-params.name}"
  db_subnet_group_name    = "${aws_db_subnet_group.rds-subnet-group.name}"
  vpc_security_group_ids  = ["${aws_security_group.security-group-rds.id}"]
  availability_zone       = "ap-northeast-1a"
  multi_az                = false
  backup_retention_period = 1
  skip_final_snapshot     = true

  tags {
    Name    = "${var.product}-${terraform.workspace}-rds"
    Product = "${var.product}"
    Env     = "${terraform.workspace}"
  }
}
