resource "aws_acm_certificate" "dd4c_certificate" {
  domain_name       = var.dd4c_domain
  validation_method = "DNS"
  provider = aws.us-east-1
}

output "aws_acm_certificate_validation_cname_record_name" {
  description = "The name of certificate's validation CNAME record"
  value       = one(aws_acm_certificate.dd4c_certificate.domain_validation_options[*].resource_record_name)
}

output "aws_acm_certificate_validation_cname_record_value" {
  description = "The value of certificate's validation CNAME record"
  value       = one(aws_acm_certificate.dd4c_certificate.domain_validation_options[*].resource_record_value)
}