resource "aws_wafv2_web_acl" "dd4c_waf_acl" {
  provider = aws.us-east-1
  name     = "DD4C-ACL"
  scope    = "CLOUDFRONT"

  default_action {
    block {}
  }

  visibility_config {
    cloudwatch_metrics_enabled = false
    metric_name                = "DD4C-WAF-Stream"
    sampled_requests_enabled   = true
  }

  rule {
    name     = "MustBeViaDomain"
    priority = 0

    statement {
      regex_pattern_set_reference_statement {
        arn = aws_wafv2_regex_pattern_set.domain_pattern.arn
        field_to_match {
          single_header {
            name = "host"
          }
        }

        text_transformation {
          priority = 0
          type     = "LOWERCASE"
        }
      }
    }

    action {
      allow {}
    }

    visibility_config {
      cloudwatch_metrics_enabled = false
      metric_name                = "restrict-requests-without-correct-host-header"
      sampled_requests_enabled   = true
    }
  }
}

resource "aws_wafv2_regex_pattern_set" "domain_pattern" {
  provider = aws.us-east-1
  name     = "DD4C_Domain"
  scope    = "CLOUDFRONT"

  regular_expression {
    regex_string = "^dd4c(?:-test)?\\.digital\\.nhs\\.uk$"
  }
}
