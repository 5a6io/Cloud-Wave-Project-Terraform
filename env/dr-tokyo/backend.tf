terraform {
  backend "s3" {
    key     = "dr-tokyo/terraform.tfstate"
    encrypt = true
  }
}
