provider "aws" {
  region = "us-west-1"
}

# resource "aws_s3_bucket" "storyrama" {
#   bucket = "storyrama"
#   acl = "private"
# }

# backend
terraform {
  backend "s3" {
    bucket = "remotebackend"
    key    = "storyrama/terraform.tfstate"
    region = "us-west-1"
    profile = "jds"
  }
}
