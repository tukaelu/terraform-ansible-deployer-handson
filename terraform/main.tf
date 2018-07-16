provider "aws" {
  access_key = "${var.access_key}"
  secret_key = "${var.secret_key}"
  region     = "ap-northeast-1"
}

terraform {
  required_version = "~> 0.10"

  backend "s3" {
    region         = "ap-northeast-1"
    bucket         = "my-remote-tfstate"
    key            = "resources/terraform-ansible-deployer/terraform.tfstate"
    dynamodb_table = "TerraformLockState"
  }
}
