terraform {
  backend "s3" {
    bucket         = "elkproject-terraform-state-global"
    key            = "dev/terraform.tfstate"
    region         = "us-east-1"
    encrypt        = true
  }
}
