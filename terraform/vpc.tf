module "vpc" {
  source = "terraform-aws-modules/vpc/aws"

  name = "${var.vpc_name}"
  cidr = "${var.vpc_cidr}"

  azs = [
    "ap-northeast-1a",
    "ap-northeast-1c",
    "ap-northeast-1d",
  ]

  private_subnets = [
    "${cidrsubnet(var.vpc_cidr, 8, 1)}",
    "${cidrsubnet(var.vpc_cidr, 8, 2)}",
    "${cidrsubnet(var.vpc_cidr, 8, 3)}",
  ]

  public_subnets = [
    "${cidrsubnet(var.vpc_cidr, 8, 11)}",
    "${cidrsubnet(var.vpc_cidr, 8, 12)}",
    "${cidrsubnet(var.vpc_cidr, 8, 13)}",
  ]

  enable_nat_gateway = true
  enable_vpn_gateway = true
  single_nat_gateway = true

  tags = {
    Terraform   = "true"
    Environment = "handson"
  }
}
