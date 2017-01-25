resource "aws_alb" "auth_alb" {
  name = "auth-alb"
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
