resource "aws_cloudwatch_log_group" "auth" {
  name = "awslogs-${var.app_name}-auth-log"
}
