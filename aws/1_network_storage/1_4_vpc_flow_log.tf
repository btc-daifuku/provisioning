#####################################
# Flow Log IAM
#####################################
resource "aws_iam_role" "flow_log" {
    name = "test_role"
    assume_role_policy = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Sid": "",
      "Effect": "Allow",
      "Principal": {
        "Service": "vpc-flow-logs.amazonaws.com"
      },
      "Action": "sts:AssumeRole"
    }
  ]
}
EOF
}

resource "aws_iam_role_policy" "flow_log" {
    name = "test_policy"
    role = "${aws_iam_role.flow_log.id}"
    policy = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Action": [
        "logs:CreateLogGroup",
        "logs:CreateLogStream",
        "logs:PutLogEvents",
        "logs:DescribeLogGroups",
        "logs:DescribeLogStreams"
      ],
      "Effect": "Allow",
      "Resource": "*"
    }
  ]
}
EOF
}

#####################################
# Public Subnet1 Flow Log Settings
#####################################
resource "aws_cloudwatch_log_group" "flow_log1" {
  name = "awslogs-${var.app_name}-vpc-flow-log-public1"
}

resource "aws_flow_log" "flow_log1" {
  log_group_name = "${aws_cloudwatch_log_group.flow_log1.name}"
  iam_role_arn = "${aws_iam_role.flow_log.arn}"
  traffic_type = "ALL"
  subnet_id = "${aws_subnet.public-subnet1.id}"

  depends_on = [
    "aws_subnet.public-subnet1"
  ]
}

#####################################
# Public Subnet2 Flow Log Settings
#####################################
resource "aws_cloudwatch_log_group" "flow_log2" {
  name = "awslogs-${var.app_name}-vpc-flow-log-public2"
}

resource "aws_flow_log" "flow_log2" {
  log_group_name = "${aws_cloudwatch_log_group.flow_log2.name}"
  iam_role_arn = "${aws_iam_role.flow_log.arn}"
  traffic_type = "ALL"
  subnet_id = "${aws_subnet.public-subnet2.id}"

  depends_on = [
    "aws_subnet.public-subnet2"
  ]
}
