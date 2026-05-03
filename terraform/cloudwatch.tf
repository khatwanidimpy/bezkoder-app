resource "aws_iam_role" "ec2_cloudwatch_role" {
  name = "ec2-cloudwatch-role"

  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [{
      Action = "sts:AssumeRole"
      Effect = "Allow"
      Principal = {
        Service = "ec2.amazonaws.com"
      }
    }]
  })
}

resource "aws_iam_role_policy_attachment" "cw_agent_policy" {
  role       = aws_iam_role.ec2_cloudwatch_role.name
  policy_arn = "arn:aws:iam::aws:policy/CloudWatchAgentServerPolicy"
}

resource "aws_iam_instance_profile" "ec2_profile" {
  name = "ec2-cloudwatch-profile"
  role = aws_iam_role.ec2_cloudwatch_role.name
}

resource "aws_cloudwatch_log_group" "app_logs" {
  name              = "/ec2/bezkoder-app"
  retention_in_days = 7
}

resource "aws_cloudwatch_dashboard" "dashboard" {
  dashboard_name = "bezkoder-dashboard"

  dashboard_body = jsonencode({
    widgets = [
      {
        type = "metric",
        x = 0,
        y = 0,
        width = 12,
        height = 6,
        properties = {
          metrics = [
            [ "AWS/EC2", "CPUUtilization", "InstanceId", aws_instance.app.id ]
          ],
          period = 300,
          stat = "Average",
          region = var.aws_region,
          title = "EC2 CPU Utilization"
        }
      },
      {
        type = "metric",
        x = 12,
        y = 0,
        width = 12,
        height = 6,
        properties = {
          metrics = [
            [ "CWAgent", "mem_used_percent", "InstanceId", aws_instance.app.id ]
          ],
          period = 300,
          stat = "Average",
          region = var.aws_region,
          title = "Memory Usage"
        }
      }
    ]
  })
}