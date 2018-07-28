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

module "front-web-a" {
  source = "terraform-aws-modules/ec2-instance/aws"

  name           = "front-web-a"
  instance_count = "${var.desired_ondemand_capacity}"

  ami           = "ami-e99f4896"
  instance_type = "t2.micro"
  key_name      = "${aws_key_pair.bastion.key_name}"
  monitoring    = true
  subnet_id     = "${element(module.vpc.private_subnets, 0)}"

  vpc_security_group_ids = [
    "${module.allow-http-sg.this_security_group_id}",
    "${module.allow-ssh-sg.this_security_group_id}",
  ]

  associate_public_ip_address = true

  tags = {
    Terraform   = "true"
    Environment = "handson"
    Role        = "front-web"
  }
}

module "front-web-c" {
  source = "terraform-aws-modules/ec2-instance/aws"

  name           = "front-web-c"
  instance_count = "${var.desired_ondemand_capacity}"

  ami           = "ami-e99f4896"
  instance_type = "t2.micro"
  key_name      = "${aws_key_pair.bastion.key_name}"
  monitoring    = true
  subnet_id     = "${element(module.vpc.private_subnets, 1)}"

  vpc_security_group_ids = [
    "${module.allow-http-sg.this_security_group_id}",
    "${module.allow-ssh-sg.this_security_group_id}",
  ]

  associate_public_ip_address = true

  tags = {
    Terraform   = "true"
    Environment = "handson"
    Role        = "front-web"
  }
}

module "front-web-d" {
  source = "terraform-aws-modules/ec2-instance/aws"

  name           = "front-web-d"
  instance_count = "${var.desired_ondemand_capacity}"

  ami           = "ami-e99f4896"
  instance_type = "t2.micro"
  key_name      = "${aws_key_pair.bastion.key_name}"
  monitoring    = true
  subnet_id     = "${element(module.vpc.private_subnets, 2)}"

  vpc_security_group_ids = [
    "${module.allow-http-sg.this_security_group_id}",
    "${module.allow-ssh-sg.this_security_group_id}",
  ]

  associate_public_ip_address = true

  tags = {
    Terraform   = "true"
    Environment = "handson"
    Role        = "front-web"
  }
}
