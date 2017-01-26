resource "aws_alb" "auth" {
  name = "${var.app_name}-auth-alb"
  internal = false
  security_groups = ["${var.security_group_public}"]
  subnets = ["${var.public_subnet_1}","${var.public_subnet_2}"]

  access_logs {
    bucket = "${var.app_name}-accesslog"
    prefix = "alb_log"
  }

  idle_timeout = 400

  tags {
      Name = "${var.app_name} auth-alb"
      Group = "${var.app_name}"
  }
}

resource "aws_alb_target_group" "auth" {
  name     = "${var.app_name}-target-group"
  port     = 80
  protocol = "HTTP"
  vpc_id   = "${var.vpc_id}"

  tags {
      Name = "${var.app_name} target-group"
      Group = "${var.app_name}"
  }
}

resource "aws_alb_listener" "auth" {
  load_balancer_arn = "${aws_alb.auth.id}"
  port              = "80"
  protocol          = "HTTP"

  default_action {
    target_group_arn = "${aws_alb_target_group.auth.id}"
    type             = "forward"
  }
}
