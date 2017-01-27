resource "aws_alb" "auth" {
  name = "${var.app_name}-auth-alb"
  internal = false
  security_groups = ["${data.aws_security_group.public.id}"]
  subnets = ["${data.aws_subnet.public_1.id}","${data.aws_subnet.public_2.id}"]

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
  vpc_id   = "${data.aws_vpc.selected.id}"

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
