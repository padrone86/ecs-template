#########################
# ECR Repositories
#########################

# Front
resource "aws_ecr_repository" "repository-front" {
  name = "${var.product}-front"
}

# API
resource "aws_ecr_repository" "repository-api" {
  name = "${var.product}-api"
}
