terraform {
  backend "s3" {
    bucket = "raba-jp.net.terraform-state"
    key = "cloud"
    region = "us-east-2"
  }
}
