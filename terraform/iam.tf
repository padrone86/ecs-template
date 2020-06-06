#########################
# IAM
#########################

# Task role
data "template_file" "task-role-template" {
  template = file("${path.root}/iam/roles/task-role.json")
}

resource "aws_iam_role" "task-role" {
  name               = "ecsTaskExecutionRole"
  assume_role_policy = data.template_file.task-role-template.rendered
}

resource "aws_iam_role_policy_attachment" "task-role-attachment" {
  role       = aws_iam_role.task-role.name
  policy_arn = "arn:aws:iam::aws:policy/service-role/AmazonECSTaskExecutionRolePolicy"
}

