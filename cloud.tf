terraform {
  backend "s3" {
    bucket = "raba-jp.net.terraform-state"
    key    = "cloud"
    region = "us-east-2"
  }
}

variable "digitalocean_token" {}

variable "aws_access_key_id" {}
variable "aws_secret_access_key" {}
variable "aws_region" {}
variable "google_credentials" {}
variable "google_project" {}
variable "google_region" {}

provider "digitalocean" {
  token = "${var.digitalocean_token}"
}

provider "aws" {
  access_key = "${var.aws_access_key_id}"
  secret_key = "${var.aws_secret_access_key}"
  region     = "${var.aws_region}"
}

provider "google" {
  credentials = "${var.google_credentials}"
  project     = "${var.google_project}"
  region      = "${var.google_region}"
}
