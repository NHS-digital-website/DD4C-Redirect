locals {
  dd4c_distribution_id = "DD4C"
}

resource "aws_cloudfront_distribution" "dd4c_distribution" {

  enabled = true

  origin {

    domain_name = split("/", aws_lambda_function_url.main_lambda_funciton_url.function_url)[2]
    origin_id   = "DD4C"
    #origin_path = "dd4c"

    custom_origin_config {
      http_port              = 80
      https_port             = 443
      origin_protocol_policy = "https-only"
      origin_ssl_protocols   = ["TLSv1.2"]
    }
  }

  default_cache_behavior {

    target_origin_id       = "DD4C"
    viewer_protocol_policy = "allow-all"

    allowed_methods = ["GET", "HEAD", "OPTIONS"]
    cached_methods  = ["GET", "HEAD"]

    forwarded_values {

      query_string = false

      cookies {
        forward = "none"
      }
    }
  }

  restrictions {

    geo_restriction {
      restriction_type = "none"
    }
  }

  viewer_certificate {

    cloudfront_default_certificate = true
  }

}
