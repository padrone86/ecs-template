locals {
  bucket_name = "${var.product}-${terraform.workspace}-frontend"
}

data "template_file" "frontend_host_policy" {
  template = file("${path.root}/bucket_policy/frontend_host_policy.json")

  vars = {
    principal_iam_arn = aws_cloudfront_origin_access_identity.origin_access_identity.iam_arn
    bucket_name = local.bucket_name
  }
}

resource "aws_s3_bucket" "frontend_host" {
  bucket = local.bucket_name
  acl    = "private"
  policy = data.template_file.frontend_host_policy.rendered

  website {
    index_document = "index.html"
    error_document = "index.html"
  }

  server_side_encryption_configuration {
    rule {
      apply_server_side_encryption_by_default {
        sse_algorithm = "AES256"
      }
    }
  }

  tags = {
    Name    = "${var.product}-${terraform.workspace}-frontend-host"
    Product = var.product
    Env     = terraform.workspace
  }
}
