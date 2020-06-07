#########################
# Provider settings
#########################

provider "aws" {
  version = "= 2.65.0"
  region  = var.region
  profile = var.profile
}

