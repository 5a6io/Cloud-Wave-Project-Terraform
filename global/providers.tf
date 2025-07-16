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
    region = "ap-northeast-2"
    alias = "seoul"
}

/** Alternate Provider **/
provider "aws" {
    region = "ap-northeast-1"
    alias = "tokyo" 
}

module "default_provider" {
    source = "./default"
    providers = {
      aws = aws.seoul
    }
}

module "alternate_provider" {
    source = "./alternate"
    providers = {
      aws = aws.tokyo
    }
}