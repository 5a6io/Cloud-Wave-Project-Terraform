resource "aws_cloudwatch_event_bus" "this" {
  name = var.bus_name

  tags = merge(var.common_tags, {
    Name = "${var.project_name}-event-bus"
  })
}

resource "aws_cloudwatch_event_rule" "this" {
  name           = var.rule_name
  event_bus_name = aws_cloudwatch_event_bus.this.name
  event_pattern  = var.event_pattern
}

resource "aws_cloudwatch_event_target" "this" {
  rule           = aws_cloudwatch_event_rule.this.name
  event_bus_name = aws_cloudwatch_event_bus.this.name
  arn            = var.target_arn
}
