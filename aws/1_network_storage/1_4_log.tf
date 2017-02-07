resource "aws_cloudwatch_log_group" "flow_log" {
  name = "awslogs-${var.app_name}-vpc-flow-log"
}
