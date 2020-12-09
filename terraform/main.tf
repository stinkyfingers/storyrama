provider "aws" {
  region = "us-west-1"
}

# resource "aws_s3_bucket" "storyrama" {
#   bucket = "storyrama"
#   acl = "private"
# }

data "archive_file" "lambda_zip" {
  type        = "zip"
  source_file = "../lambdas/test/lambda.js"
  output_path = "${path.module}/lambda.zip"
}

resource "aws_lambda_function" "test_lambda" {
  filename = "${path.module}/lambda.zip"
  function_name = "test_lambda"
  handler = "lambda.handler"
  source_code_hash = data.archive_file.lambda_zip.output_base64sha256
  runtime = "nodejs12.x"
  role = aws_iam_role.lambda_role.arn
}

resource "aws_iam_role" "lambda_role" {
  name = "test-lambda-role"
  assume_role_policy = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Action": "sts:AssumeRole",
      "Principal": {
        "Service": "lambda.amazonaws.com"
      },
      "Effect": "Allow",
      "Sid": ""
    }
  ]
}
EOF
}

# backend
terraform {
  backend "s3" {
    bucket = "remotebackend"
    key    = "storyrama/terraform.tfstate"
    region = "us-west-1"
    profile = "jds"
  }
}
