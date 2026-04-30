output "security_hub_enabled" {
  value = aws_securityhub_account.this.id != ""
}
