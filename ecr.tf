#########################
# ECR Repositories
#########################

# Front
resource "aws_ecr_repository" "repository-front" {
  name = "${var.product}-front"

  provisioner "local-exec" {
    command = "build-image.sh front ${self.repository_url} ${self.name}"
  }
}

# API
resource "aws_ecr_repository" "repository-api" {
  name = "${var.product}-api"

  provisioner "local-exec" {
    command = "build-image.sh api ${self.repository_url} ${self.name}"
  }
}
