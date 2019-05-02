#########################
# ECS - Fargate
#########################

# ECS Cluster
resource "aws_ecs_cluster" "ecs-cluster" {
  name = "${var.product}-${terraform.workspace}-ecs-cluster"
}

# Services

# Frontend
resource "aws_ecs_service" "front-service" {
  name                               = "${var.product}-${terraform.workspace}-front-service"
  cluster                            = "${aws_ecs_cluster.ecs-cluster.id}"
  task_definition                    = "${aws_ecs_task_definition.front-task-definition.arn}"
  launch_type                        = "FARGATE"
  desired_count                      = 1
  deployment_minimum_healthy_percent = 100
  deployment_maximum_percent         = 200
  health_check_grace_period_seconds  = 60

  network_configuration {
    subnets          = ["${aws_subnet.subnet-public-a.id}", "${aws_subnet.subnet-public-c.id}"]
    security_groups  = ["${aws_security_group.security-group-front.id}"]
    assign_public_ip = "true"
  }

  load_balancer {
    target_group_arn = "${aws_alb_target_group.alb-target-group-front.arn}"
    container_name   = "${var.product}-${terraform.workspace}-front-container"
    container_port   = 80
  }

  depends_on = ["aws_ecs_service.api-service"]
}

# API
resource "aws_ecs_service" "api-service" {
  name                               = "${var.product}-${terraform.workspace}-api-service"
  cluster                            = "${aws_ecs_cluster.ecs-cluster.id}"
  task_definition                    = "${aws_ecs_task_definition.api-task-definition.arn}"
  launch_type                        = "FARGATE"
  desired_count                      = 1
  deployment_minimum_healthy_percent = 100
  deployment_maximum_percent         = 200

  network_configuration {
    subnets          = ["${aws_subnet.subnet-public-a.id}", "${aws_subnet.subnet-public-c.id}"]
    security_groups  = ["${aws_security_group.security-group-api.id}"]
    assign_public_ip = "true"
  }

  load_balancer {
    target_group_arn = "${aws_alb_target_group.alb-target-group-api.arn}"
    container_name   = "${var.product}-${terraform.workspace}-api-container"
    container_port   = 8080
  }

  depends_on = ["aws_alb.alb"]
}
