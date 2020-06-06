##############################
# Fargate task definition
##############################

# API
data "template_file" "api-container-template" {
  template = "${file("${path.root}/task-definitions/api.json")}"

  vars {
    product   = "${var.product}"
    env       = "${terraform.workspace}"
    image-url = "${aws_ecr_repository.repository-api.repository_url}"
    cpu       = "${var.api_cpu}"
    memory    = "${var.api_memory}"
    fuga      = "zoy"
  }
}

resource "aws_ecs_task_definition" "api-task-definition" {
  family                   = "${var.product}-${terraform.workspace}-api-task"
  container_definitions    = "${data.template_file.api-container-template.rendered}"
  task_role_arn            = "${aws_iam_role.task-role.arn}"
  execution_role_arn       = "${aws_iam_role.task-role.arn}"
  network_mode             = "awsvpc"
  requires_compatibilities = ["FARGATE"]
  cpu                      = "${var.api_cpu}"
  memory                   = "${var.api_memory}"

  provisioner "local-exec" {
    command = "./push-image.sh ${var.profile} api ${aws_ecr_repository.repository-api.name} ${aws_ecr_repository.repository-api.repository_url}"
  }
}
