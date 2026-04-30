output "log_group_arn" {
  value = aws_cloudwatch_log_group.this.arn
}

output "alarm_arn" {
  value = aws_cloudwatch_metric_alarm.high_cpu.arn
}
