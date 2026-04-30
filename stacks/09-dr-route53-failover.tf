########################################
# Route53 Failover (Primary: 서울, Secondary: 도쿄)
########################################
resource "aws_route53_health_check" "primary" {
  count = var.enable_dr_tokyo && var.create_route53_failover ? 1 : 0

  fqdn              = var.primary_fqdn
  type              = "HTTPS"
  resource_path     = var.primary_health_check_path
  port              = 443
  failure_threshold = 3
  request_interval  = 30

  tags = merge(var.common_tags, {
    Name = "${var.project_name}-primary-health-check"
  })
}

resource "aws_route53_record" "primary_failover" {
  count = var.enable_dr_tokyo && var.create_route53_failover ? 1 : 0

  zone_id = var.hosted_zone_id
  name    = var.service_fqdn
  type    = "A"

  set_identifier = "primary-seoul"
  failover_routing_policy {
    type = "PRIMARY"
  }

  alias {
    name                   = var.primary_lb_dns_name
    zone_id                = var.primary_lb_zone_id
    evaluate_target_health = true
  }

  health_check_id = aws_route53_health_check.primary[0].id
}

resource "aws_route53_record" "secondary_failover" {
  count = var.enable_dr_tokyo && var.create_route53_failover ? 1 : 0

  zone_id = var.hosted_zone_id
  name    = var.service_fqdn
  type    = "A"

  set_identifier = "secondary-tokyo"
  failover_routing_policy {
    type = "SECONDARY"
  }

  alias {
    name                   = var.secondary_lb_dns_name
    zone_id                = var.secondary_lb_zone_id
    evaluate_target_health = true
  }
}
