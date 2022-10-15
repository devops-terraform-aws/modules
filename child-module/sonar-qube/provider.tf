provider "aws" {
  region = var.region
}

terraform {
  required_version = ">= 0.13.1"
  #   backend "http" {}

  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = ">= 4.20.0"
    }
  }
}
