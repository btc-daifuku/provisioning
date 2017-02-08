#####################################
# OpenAM Service Setting
#####################################
resource "aws_ecs_service" "openam" {
  name = "${var.app_name}-auth-service"
  cluster = "${aws_ecs_cluster.auth.id}"
  task_definition = "${aws_ecs_task_definition.openam.arn}"
  desired_count = 1
  iam_role = "ecsServiceRole"

  load_balancer {
    target_group_arn = "${aws_alb_target_group.openam.id}"
    container_name = "OpenAM"
    container_port = 8080
  }

  depends_on = [
    "aws_alb_listener.openam"
  ]
}

#####################################
# OpenDJ Service Setting
#####################################
resource "aws_ecs_service" "opendj" {
  name = "${var.app_name}-ldap-service"
  cluster = "${aws_ecs_cluster.auth.id}"
  task_definition = "${aws_ecs_task_definition.opendj.arn}"
  desired_count = 1
  iam_role = "ecsServiceRole"

  load_balancer {
    target_group_arn = "${aws_alb_target_group.opendj.id}"
    container_name = "OpenDJ"
    container_port = 389
  }

  depends_on = [
    "aws_alb_listener.opendj"
  ]
}
