terraform {
  required_providers {
    aws = {
        source = "hashicorp/aws"
        version = ""
    }
  }
}
provider "aws" {
    region = "ap-northeast-1"
}