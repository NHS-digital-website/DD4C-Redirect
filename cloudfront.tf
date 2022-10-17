resource "aws_cloudfront_distribution" "dd4c_distribution" {
  enabled     = true
  price_class = "PriceClass_100"

  origin {
    domain_name = split("/", aws_lambda_function_url.main_lambda_funciton_url.function_url)[2]
    origin_id   = "DD4C"

    origin_shield {
      enabled              = true
      origin_shield_region = "eu-west-2"
    }

    custom_header {
      name  = "integrity"
      value = sha256(var.integrity)
    }

    custom_origin_config {
      http_port              = 80
      https_port             = 443
      origin_protocol_policy = "https-only"
      origin_ssl_protocols   = ["TLSv1.2"]
    }
  }

  default_cache_behavior {
    target_origin_id       = "DD4C"
    viewer_protocol_policy = "redirect-to-https"

    allowed_methods = ["GET", "HEAD", "OPTIONS"]
    cached_methods  = ["GET", "HEAD"]

    forwarded_values {
      query_string = false

      cookies {
        forward = "none"
      }
      headers = ["referer"]
    }
  }

  restrictions {
    geo_restriction {
      restriction_type = "none"
    }
  }

  viewer_certificate {
    acm_certificate_arn      = aws_acm_certificate.dd4c_certificate.arn
    ssl_support_method       = "sni-only"
    minimum_protocol_version = "TLSv1.2_2021"
  }

  aliases = [
    var.dd4c_domain
  ]

  web_acl_id = aws_wafv2_web_acl.dd4c_waf_acl.arn

}
