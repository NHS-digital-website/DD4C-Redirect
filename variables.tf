variable "dd4c_domain" {
  default = "dd4c.digital.nhs.uk"
}

variable "dd4c_test_domain" {
  default = "dd4c-test.digital.nhs.uk"
}

variable "integrity" {
  description = "A hashed version of the value given gets passed between CloudFront and the Lambda to check the integrity of the request"
  type        = string
}

variable "aws_details_tag" {
  default = "DD4C Redirection Service"
}
