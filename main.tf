##############################
# Terraform backend settings
##############################

terraform {
  required_version = ">= 0.11.0"

  backend "s3" {
    region  = "ap-northeast-1"
    profile = "private"
    bucket  = "dev-aoki-tfbackend"
    key     = "tfbackend/terraform.tfstate"
  }
}
