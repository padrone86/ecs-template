#########################
# Load balancer
#########################

# ALB

resource "aws_alb" "alb" {
  name               = "${var.product}-${terraform.workspace}-alb"
  internal           = false
  load_balancer_type = "application"
  security_groups    = ["${aws_security_group.security-group-alb.id}"]
  subnets            = ["${aws_subnet.subnet-public-a.id}", "${aws_subnet.subnet-public-c.id}"]

  tags {
    Name    = "${var.product}-${terraform.workspace}-alb"
    Product = "${var.product}"
    Env     = "${terraform.workspace}"
  }
}

# ALB target group

resource "aws_alb_target_group" "alb-target-group-api" {
  name        = "${var.product}-${terraform.workspace}-alb-tg-api"
  port        = 8080
  protocol    = "HTTP"
  vpc_id      = "${aws_vpc.vpc.id}"
  target_type = "ip"

  health_check {
    interval            = 60
    path                = "/health-chesk"
    protocol            = "HTTP"
    timeout             = 20
    unhealthy_threshold = 4
    matcher             = 200
  }

  tags {
    Name    = "${var.product}-${terraform.workspace}-alb-target-group-api"
    Product = "${var.product}"
    Env     = "${terraform.workspace}"
  }
}

# ALB Listener

resource "aws_alb_listener" "alb-listener-api" {
  load_balancer_arn = "${aws_alb.alb.arn}"
  port              = "8080"
  protocol          = "HTTP"

  default_action {
    target_group_arn = "${aws_alb_target_group.alb-target-group-api.arn}"
    type             = "forward"
  }
}
