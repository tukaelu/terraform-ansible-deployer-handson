resource "aws_alb" "front-web-alb" {
  name            = "front-web-alb"
  internal        = false
  security_groups = ["${module.allow-http-from-internet-sg.this_security_group_id}"]
  subnets         = ["${module.vpc.public_subnets}"]

  tags {
    Environment = "handson"
  }
}

resource "aws_alb_target_group" "front-web-alb" {
  name     = "front-web-alb"
  port     = 80
  protocol = "HTTP"
  vpc_id   = "${module.vpc.vpc_id}"

  health_check {
    interval            = 30
    path                = "/index.html"
    port                = 80
    protocol            = "HTTP"
    timeout             = 5
    unhealthy_threshold = 2
    matcher             = 200
  }
}

resource "aws_alb_listener" "front-web-alb" {
  load_balancer_arn = "${aws_alb.front-web-alb.arn}"
  port              = 80
  protocol          = "HTTP"

  default_action {
    target_group_arn = "${aws_alb_target_group.front-web-alb.arn}"
    type             = "forward"
  }
}

resource "aws_autoscaling_attachment" "front-web-alb" {
  autoscaling_group_name = "${module.front-asg.this_autoscaling_group_id}"
  alb_target_group_arn   = "${aws_alb_target_group.front-web-alb.arn}"
}
