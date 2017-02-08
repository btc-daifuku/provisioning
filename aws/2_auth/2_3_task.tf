#####################################
# OpenAM Task Setting
#####################################
data "template_file" "openam_task" {
  template = "${file("task/openam.json")}"

  vars {
    app_name           = "${var.app_name}"
    aws_region         = "${var.region}"
  }
}

resource "aws_ecs_task_definition" "openam" {
  family = "openam"
  container_definitions = "${data.template_file.openam_task.rendered}"

  depends_on = [
    "aws_cloudwatch_log_group.auth"
  ]
}

#####################################
# OpenDJ Task Setting
#####################################
data "template_file" "opendj_task" {
  template = "${file("task/opendj.json")}"

  vars {
    app_name           = "${var.app_name}"
    aws_region         = "${var.region}"
  }
}

resource "aws_ecs_task_definition" "opendj" {
  family = "opendj"
  container_definitions = "${data.template_file.opendj_task.rendered}"

  depends_on = [
    "aws_cloudwatch_log_group.auth"
  ]
}
