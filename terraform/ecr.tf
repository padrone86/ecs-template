#########################
# ECR Repositories
#########################

# API
resource "aws_ecr_repository" "repository-api" {
  name = "${var.product}-api"

  image_scanning_configuration {
    scan_on_push = true
  }
}
