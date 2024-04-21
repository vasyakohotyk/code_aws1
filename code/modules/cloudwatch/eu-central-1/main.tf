module "label" {
  source  = "cloudposse/label/null"
  version = "0.25.0"
  context = var.context
  name    = var.name
}

# module "notify_slack" {
#   source  = "terraform-aws-modules/notify-slack/aws"
#   version = "5.6.0"

#   sns_topic_name      = module.label.id
#   lambda_function_name = module.label.id

#   slack_webhook_url = var.slack_webhook_url
#   slack_channel     = "aws-notification"
#   slack_username    = "terraform-reporter"
# }

# resource "aws_sns_topic_subscription" "email" {
#   topic_arn = module.notify_slack.slack_topic_arn
#   protocol  = "email"
#   endpoint  = var.email
# }

resource "aws_cloudwatch_log_metric_filter" "this" {

  name           = "${module.label.id}-${var.function_name}-metric-filter"
  pattern        = "?ERROR ?WARN ?5xx"
  log_group_name = "/aws/lambda/${var.function_name}"

  metric_transformation {
    name      = "${module.label.id}-${var.function_name}-metric"
    namespace = "${module.label.id}-${var.function_name}"
    value     = "1"
  }
}

resource "aws_cloudwatch_metric_alarm" "this" {
  alarm_name          = "${module.label.id}-${var.function_name}-alarm"
  comparison_operator = "GreaterThanOrEqualToThreshold"
  evaluation_periods  = "1"
  metric_name         = "Errors"
  namespace           = "AWS/Lambda"
  period              = "60"
  statistic           = "Sum"
  threshold           = "1"
  alarm_description   = "This metric monitors ${var.function_name}"
  treat_missing_data  = "notBreaching"
  dimensions = {
    "FunctionName" = var.function_name
  }
  datapoints_to_alarm = 1
  actions_enabled     = "true"
  alarm_actions       = [ aws_sns_topic.this.arn]
  ok_actions          = [ aws_sns_topic.this.arn]
}
resource "aws_sns_topic" "this" {
  name = module.label.id
}

resource "aws_sns_topic_subscription" "this" {
    topic_arn = aws_sns_topic.this.arn
    protocol = "email"
    endpoint = var.email
}