resource "aws_lambda_function" "this" {
  function_name    = var.function_name
  role             = var.role_arn
  handler          = var.handler
  runtime          = var.runtime
  filename         = var.filename
  source_code_hash = var.source_code_hash

  tags = merge(var.common_tags, {
    Name = "${var.project_name}-lambda"
  })
}
