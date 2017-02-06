resource "aws_ecs_service" "auth" {
  name = "${var.app_name}-auth-service"
  cluster = "${aws_ecs_cluster.auth.id}"
  task_definition = "${aws_ecs_task_definition.auth.arn}"
  desired_count = 1
  iam_role = "ecsServiceRole"

  load_balancer {
    target_group_arn = "${aws_alb_target_group.auth.id}"
    #elb_name = "${aws_elb.auth.name}"
    container_name = "OpenAM"
    container_port = 8080
  }

  depends_on = [
    "aws_alb_listener.auth"
    #"aws_elb.auth"
  ]
}
