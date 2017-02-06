data "template_file" "user_data" {
  template = "${file("bash/userdata.sh")}"

  vars {
    cluster_name = "${aws_ecs_cluster.auth.name}"
  }
}

resource "aws_launch_configuration" "auth" {
    name = "${var.app_name}-launch-configuration"
    image_id = "${lookup(var.aws_amis, var.region)}"
    key_name = "${var.ssh_key_name}"
    instance_type = "${var.instance_type}"
    iam_instance_profile = "ecsInstanceRole"
    security_groups = [
        "${data.aws_security_group.public.id}"
    ]

    user_data = "${data.template_file.user_data.rendered}"
}

resource "aws_autoscaling_group" "auth" {
  availability_zones = ["${var.az1}"]
  name = "${var.app_name}-autoscaling-group"
  vpc_zone_identifier  = ["${data.aws_subnet.public_1.id}"]
  max_size = 1
  min_size = 1
  desired_capacity = 1
  health_check_grace_period = 300
  health_check_type = "ELB"
  force_delete = true
  launch_configuration = "${aws_launch_configuration.auth.name}"
}
