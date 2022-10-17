terraform {
  backend "s3" {
    bucket = "dd4c-terraform-state"
    key    = "production.tfstate"
    region = "eu-west-2"
  }
}

# Default AWS region
provider "aws" {
  region = "eu-west-2"
}

# Aditional AWS region that AWS CloudFront needs for:
# - SSL Certificates 
# - Edge Lambdas
# - etc.
provider "aws" {
  alias  = "us-east-1"
  region = "us-east-1"
}
