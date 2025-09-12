terraform {
  required_providers {
    aws = {
      source = "hashicorp/aws"
      version = ">=6.12.0"
    }
  }
  required_version = "~> 1.13"
}

provider "aws" {
  region     = "us-east-2"
  alias      = "ohio"
}

provider "aws" {
  region     = "us-east-1"
  alias      = "virginia"
}