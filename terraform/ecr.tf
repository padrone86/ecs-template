#########################
# ECR Repositories
#########################

# API
resource "aws_ecr_repository" "repository-api" {
  name = "${var.product}-api"

  provisioner "local-exec" {
    command = "./push-image.sh ${var.profile} api ${aws_ecr_repository.repository-api.name} ${aws_ecr_repository.repository-api.repository_url}"
  }
}
