terraform {
  backend "s3" {
    bucket         = "elkproject-terraform-state-global"
    key            = "prod/terraform.tfstate"
    region         = "us-east-1"
    encrypt        = true
  }
}
