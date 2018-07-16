module "allow-ssh-sg" {
  source = "terraform-aws-modules/security-group/aws//modules/ssh"

  name        = "allow-ssh-sg"
  description = "allow ssh access"
  vpc_id      = "${module.vpc.vpc_id}"

  ingress_cidr_blocks = ["${var.allow_ssh_ip}"]
}

module "allow-http-sg" {
  source = "terraform-aws-modules/security-group/aws//modules/http-80"

  name        = "allow-http-sg"
  description = "allow http access"
  vpc_id      = "${module.vpc.vpc_id}"

  ingress_cidr_blocks = ["${var.vpc_cidr}"]
}
