resource "aws_kms_key" "this" {
  description             = "${var.project_name} encryption key"
  deletion_window_in_days = var.deletion_window_in_days
  enable_key_rotation     = true

  tags = merge(var.common_tags, {
    Name = "${var.project_name}-kms"
  })
}

resource "aws_kms_alias" "this" {
  name          = "alias/${var.project_name}-key"
  target_key_id = aws_kms_key.this.key_id
}
