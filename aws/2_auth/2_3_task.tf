resource "aws_ecs_task_definition" "auth" {
  family = "auth"
  container_definitions = "${file("task/auth.json")}"
}
