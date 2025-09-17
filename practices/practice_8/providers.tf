terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = ">=6.12.0"
    }

    random = {
      source = "hashicorp/random"
      version = "3.7.2"
    }
  }
  required_version = "~> 1.13"
}

provider "aws" {
  region = "us-east-2"
  alias  = "ohio"

  #agregar tags por default a todos los recursos v.26
  default_tags {
    tags = var.tags
  }
}