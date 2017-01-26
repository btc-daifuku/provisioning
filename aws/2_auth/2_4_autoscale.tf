resource "aws_launch_configuration" "auth" {
    name = "${var.app_name}-launch-configuration"
    image_id = "${lookup(var.aws_amis, var.region)}"
    key_name = "${var.ssh_key_name}"
    instance_type = "${var.instance_type}"
    iam_instance_profile = "ecsInstanceRole"
    security_groups = [
        "${var.security_group_public}"
    ]

    user_data = "${file("bash/userdata.sh")}"
}

resource "aws_autoscaling_group" "auth" {
  availability_zones = ["${var.az1}"]
  name = "${var.app_name}-autoscaling-group"
  vpc_zone_identifier  = ["${var.public_subnet_1}"]
  max_size = 1
  min_size = 1
  desired_capacity = 1
  health_check_grace_period = 300
  health_check_type = "ELB"
  force_delete = true
  launch_configuration = "${aws_launch_configuration.auth.name}"
}
