#####################################
# OpenAM ALB Setting
#####################################
resource "aws_alb" "openam" {
  name = "${var.app_name}-openam-alb"
  internal = false
  security_groups = ["${data.aws_security_group.public.id}"]
  subnets = ["${data.aws_subnet.public_1.id}","${data.aws_subnet.public_2.id}"]

  access_logs {
    bucket = "${var.app_name}-accesslog"
    prefix = "alb_log"
  }

  idle_timeout = 400

  tags {
      Name = "${var.app_name} openam-alb"
      Group = "${var.app_name}"
  }
}

resource "aws_alb_target_group" "openam" {
  name     = "${var.app_name}-openam-target-group"
  port     = 80
  protocol = "HTTP"
  vpc_id   = "${data.aws_vpc.selected.id}"

  tags {
      Name = "${var.app_name} openam-target-group"
      Group = "${var.app_name}"
  }
}

resource "aws_alb_listener" "openam" {
  load_balancer_arn = "${aws_alb.openam.id}"
  port              = "80"
  protocol          = "HTTP"

  default_action {
    target_group_arn = "${aws_alb_target_group.openam.id}"
    type             = "forward"
  }
}

#####################################
# OpenDJ ALB Setting
#####################################
resource "aws_alb" "opendj" {
  name = "${var.app_name}-opendj-alb"
  internal = true
  security_groups = ["${data.aws_security_group.private.id}"]
  subnets = ["${data.aws_subnet.private_1.id}","${data.aws_subnet.private_2.id}"]

  access_logs {
    bucket = "${var.app_name}-accesslog"
    prefix = "alb_log"
  }

  idle_timeout = 400

  tags {
      Name = "${var.app_name} opendj-alb"
      Group = "${var.app_name}"
  }
}

resource "aws_alb_target_group" "opendj" {
  name     = "${var.app_name}-opendj-target-group"
  port     = 80
  protocol = "HTTP"
  vpc_id   = "${data.aws_vpc.selected.id}"

  tags {
      Name = "${var.app_name} opendj-target-group"
      Group = "${var.app_name}"
  }
}

resource "aws_alb_listener" "opendj" {
  load_balancer_arn = "${aws_alb.opendj.id}"
  port              = "80"
  protocol          = "HTTP"

  default_action {
    target_group_arn = "${aws_alb_target_group.opendj.id}"
    type             = "forward"
  }
}
