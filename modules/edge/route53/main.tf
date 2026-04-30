resource "aws_route53_zone" "this" {
  name = var.zone_name

  tags = merge(var.common_tags, {
    Name = var.zone_name
  })
}

resource "aws_route53_record" "alias_a" {
  zone_id = aws_route53_zone.this.zone_id
  name    = var.record_name
  type    = "A"

  alias {
    name                   = var.cloudfront_domain_name
    zone_id                = var.cloudfront_hosted_zone_id
    evaluate_target_health = false
  }
}
