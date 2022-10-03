terraform {
  backend "s3" {
    bucket = "dd4c-terraform-state"
    key    = "production.tfstate"
    region = "eu-west-2"
  }
}

provider "aws" {
  region = "eu-west-2"
}