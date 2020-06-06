#########################
# ECR Repositories
#########################

# API
resource "aws_ecr_repository" "repository-api" {
  name = "${var.product}-api"
}
