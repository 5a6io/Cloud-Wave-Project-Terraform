resource "aws_sns_topic" "this" {
  name = var.topic_name

  tags = merge(var.common_tags, {
    Name = "${var.project_name}-sns"
  })
}

resource "aws_sns_topic_subscription" "sqs" {
  count = var.sqs_endpoint_arn == null ? 0 : 1

  topic_arn = aws_sns_topic.this.arn
  protocol  = "sqs"
  endpoint  = var.sqs_endpoint_arn
}
