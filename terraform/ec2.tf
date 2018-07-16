module "bastion" {
  source = "terraform-aws-modules/ec2-instance/aws"

  name           = "bastion"
  instance_count = 1

  ami                    = "ami-e99f4896"
  instance_type          = "t2.micro"
  key_name               = "${aws_key_pair.bastion.key_name}"
  monitoring             = true
  vpc_security_group_ids = ["${module.allow-ssh-sg.this_security_group_id}"]
  subnet_id              = "${element(module.vpc.public_subnets, 0)}"

  associate_public_ip_address = true

  tags = {
    Terraform   = "true"
    Environment = "handson"
  }
}
