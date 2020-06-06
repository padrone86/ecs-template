#########################
# ECR Repositories
#########################

# API
resource "aws_ecr_repository" "repository-api" {
  name = "${var.product}-api"

  image_scanning_configuration {
    scan_on_push = true
  }
  provisioner "local-exec" {
    command = "../scripts/push-image.sh ${var.profile} ../api ${aws_ecr_repository.repository-api.name} ${aws_ecr_repository.repository-api.repository_url}"
  }
}
