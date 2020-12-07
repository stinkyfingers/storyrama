provider "aws" {
  region = "us-west-1"
}

resource "aws_s3_bucket" "storyrama" {
  bucket = "storyrama"
  acl = "private"
}
