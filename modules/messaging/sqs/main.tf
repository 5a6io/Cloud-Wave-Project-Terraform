resource "aws_sqs_queue" "dlq" {
  count = var.create_dlq ? 1 : 0

  name = "${var.queue_name}-dlq"

  tags = merge(var.common_tags, {
    Name = "${var.project_name}-dlq"
  })
}

resource "aws_sqs_queue" "this" {
  name                       = var.queue_name
  visibility_timeout_seconds = var.visibility_timeout_seconds

  redrive_policy = var.create_dlq ? jsonencode({
    deadLetterTargetArn = aws_sqs_queue.dlq[0].arn
    maxReceiveCount     = 5
  }) : null

  tags = merge(var.common_tags, {
    Name = "${var.project_name}-sqs"
  })
}
