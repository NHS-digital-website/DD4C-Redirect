resource "aws_acm_certificate" "dd4c_service_certificate" {
  provider          = aws.us-east-1
  domain_name       = var.dd4c_domain
  validation_method = "DNS"
  subject_alternative_names = ["*.${var.dd4c_domain}", var.dd4c_test_domain]

  lifecycle {
    create_before_destroy = true
  }
}

output "aws_certificate_validation_cname_records" {
  description = "The name of certificate's validation CNAME record"
  value       = aws_acm_certificate.dd4c_service_certificate.domain_validation_options
}