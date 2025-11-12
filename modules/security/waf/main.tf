resource "aws_wafv2_web_acl" "this" {
  name = "${var.project_name}-waf"
  scope = "CLOUDFRONT"

  default_action {
    allow {}
  }

  visibility_config {
    cloudwatch_metrics_enabled = true
    metric_name = "waf"
    sampled_requests_enabled = false
  }

  ########################################
  # 0. MAX_REQUEST_1000 (rate-based block)
  ########################################
  rule {
    name = "RateBasedRuleSet"
    priority = 0

    action {
      block {}
    }

    statement {
      rate_based_statement {
        limit = 1000
        aggregate_key_type = "IP"
      }
    }

    visibility_config {
      cloudwatch_metrics_enabled = true
      metric_name = "MAX_REQUEST_1000"
      sampled_requests_enabled = true
    }
  }

  ################################
  # 1. AWSManagedRulesAmazonIpReputationList
  ################################
  rule {
    name     = "AWS-AWSManagedRulesAmazonIpReputationList"
    priority = 1

    override_action {
      none {} # use basic action of administrative rule
    }

    statement {
      managed_rule_group_statement {
        vendor_name = "AWS"
        name        = "AWSManagedRulesAmazonIpReputationList"
      }
    }

    visibility_config {
      cloudwatch_metrics_enabled = true
      metric_name                = "AmazonIpReputationList"
      sampled_requests_enabled   = true
    }
  }

  ################################
  # 2. AWSManagedRulesAnonymousIpList
  ################################
  rule {
    name     = "AWS-AWSManagedRulesAnonymousIpList"
    priority = 2

    override_action {
      none {}
    }

    statement {
      managed_rule_group_statement {
        vendor_name = "AWS"
        name        = "AWSManagedRulesAnonymousIpList"
      }
    }

    visibility_config {
      cloudwatch_metrics_enabled = true
      metric_name                = "AnonymousIpList"
      sampled_requests_enabled   = true
    }
  }
  
  ################################
  # 3. Common rule set (OWASP Top 10 대응)
  ################################
  rule {
    name     = "AWSManagedRulesCommonRuleSet"
    priority = 3
    override_action {
      none {}
    }
    statement {
      managed_rule_group_statement {
        name        = "AWSManagedRulesCommonRuleSet"
        vendor_name = "AWS"

        rule_action_override {
          action_to_use {
            allow {}
          }
          name = "NoUserAgent_HEADER"
        }
      }
    }
    visibility_config {
      cloudwatch_metrics_enabled = true
      metric_name                = "AWSManagedRulesCommonRuleSet"
      sampled_requests_enabled   = true
    }
  }

  ################################
  # 4. AWSManagedRulesAdminProtectionRuleSet
  ################################
  rule {
    name     = "AWS-AWSManagedRulesAdminProtectionRuleSet"
    priority = 4

    override_action {
      none {}
    }

    statement {
      managed_rule_group_statement {
        vendor_name = "AWS"
        name        = "AWSManagedRulesAdminProtectionRuleSet"
      }
    }

    visibility_config {
      cloudwatch_metrics_enabled = true
      metric_name                = "AdminProtectionRuleSet"
      sampled_requests_enabled   = true
    }
  }

  ################################
  # 5. Known Bad Inputs
  ################################
  rule {
    name     = "AWSManagedRulesKnownBadInputsRuleSet"
    priority = 5
    override_action {
      none {}
    }

    statement {
      managed_rule_group_statement {
        name        = "AWSManagedRulesKnownBadInputsRuleSet"
        vendor_name = "AWS"
      }
    }

    visibility_config {
      cloudwatch_metrics_enabled = true
      metric_name                = "AWSManagedRulesKnownBadInputsRuleSet"
      sampled_requests_enabled   = true
    }
  }

  ########################################
  # 6. SQL Injection
  ########################################
  rule {
    name = "AWSManagedRulesSQLiRuleSet"
    priority = 6

    override_action {
      none {}
    }

    statement {
      managed_rule_group_statement {
        vendor_name = "AWS"
        name = "AWSManagedRulesSQLiRuleSet"
      }
    }

    visibility_config {
      cloudwatch_metrics_enabled = true
      metric_name = "AWSManagedRulesSQLiRuleSet"
      sampled_requests_enabled = true
    }
  }

  tags = merge(var.common_tags, {
    Name = "${var.project_name}-waf"
  })
}

resource "aws_wafv2_web_acl_association" "this" {
  resource_arn = var.cloudfront_arn
  web_acl_arn = aws_wafv2_web_acl.this.arn
}

resource "aws_wafv2_web_acl_logging_configuration" "waf_logging" {
  resource_arn = aws_wafv2_web_acl.this.arn
  log_destination_configs = [
    var.waf_log_group_arn
  ]
}