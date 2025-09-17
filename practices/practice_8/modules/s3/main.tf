terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = ">=6.12.0"
    }
  }
  required_version = "~> 1.13"
}

resource "aws_s3_bucket" "certified_bucket" {
  bucket = var.bucket_name
}