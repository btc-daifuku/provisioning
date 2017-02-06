data "template_file" "openam_task" {
  template = "${file("task/auth.json")}"

  vars {
    app_name           = "${var.app_name}"
    aws_region         = "${var.region}"
  }
}

resource "aws_ecs_task_definition" "auth" {
  family = "auth"
  container_definitions = "${data.template_file.openam_task.rendered}"
}
