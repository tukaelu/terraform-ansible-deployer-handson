module "allow-ssh-sg" {
  source = "terraform-aws-modules/security-group/aws//modules/ssh"

  name        = "allow-ssh-sg"
  description = "allow ssh access"
  vpc_id      = "${module.vpc.vpc_id}"

  ingress_cidr_blocks = ["${var.allow_ssh_ip}"]
}
