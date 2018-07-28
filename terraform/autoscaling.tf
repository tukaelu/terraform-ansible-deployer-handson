module "front-web-scaling" {
  source = "terraform-aws-modules/autoscaling/aws"

  name = "front-web-scaling"

  lc_name = "handson-front-lc"

  image_id      = "ami-e99f4896"
  instance_type = "t2.micro"
  key_name      = "${aws_key_pair.bastion.key_name}"

  security_groups = [
    "${module.allow-http-sg.this_security_group_id}",
    "${module.allow-ssh-sg.this_security_group_id}",
  ]

  ebs_block_device = [
    {
      device_name           = "/dev/xvdz"
      volume_type           = "gp2"
      volume_size           = "16"
      delete_on_termination = true
    },
  ]

  root_block_device = [
    {
      volume_size = "16"
      volume_type = "gp2"
    },
  ]

  asg_name                  = "front-web-scaling"
  vpc_zone_identifier       = ["${module.vpc.private_subnets}"]
  health_check_type         = "EC2"
  min_size                  = 0
  max_size                  = "${var.autoscale_max_size}"
  desired_capacity          = "${var.autoscale_desired_capasity}"
  wait_for_capacity_timeout = 0

  tags = [
    {
      key                 = "Environment"
      value               = "handson"
      propagate_at_launch = true
    },
    {
      key                 = "Role"
      value               = "front-web"
      propagate_at_launch = true
    },
    {
      key                 = "AutoScaling"
      value               = "true"
      propagate_at_launch = true
    },
    {
      key                 = "Terraform"
      value               = "true"
      propagate_at_launch = true
    },
  ]
}
