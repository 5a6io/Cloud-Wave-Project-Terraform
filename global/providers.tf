terraform {
  required_providers {
    aws = {
        source = "hashicorp/aws"
        version = "~> 3.0"
    }
  }

  required_version = ">= 1.2.0"
}

/** Default Provider **/
provider "aws" {
    region = var.default_region #"ap-northeast-2"
    alias = "seoul"
}

/** Alternate Provider **/
provider "aws" {
    region = var.alterante_region #"ap-northeast-1"
    alias = "tokyo" 
}

module "default_provider" {
    source = "../env/prod-seoul"
    providers = {
      aws = aws.seoul
    }
}

module "alternate_provider" {
    source = "../env/dr-tokyo"
    providers = {
      aws = aws.tokyo
    }
}