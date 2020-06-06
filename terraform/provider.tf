#########################
# Provider settings
#########################

provider "aws" {
  region  = "${var.region}"
  profile = "${var.profile}"
}
