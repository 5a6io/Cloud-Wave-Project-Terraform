terraform {
  backend "s3" {
    key     = "prod-seoul/terraform.tfstate"
    encrypt = true
  }
}
