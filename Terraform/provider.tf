terraform {
  required_providers {
    aws = {
      source = "hashicorp/aws"
      version = "5.85.0"
    }
  }
}

provider "aws" {
  # Configuration options
  region = "ap-south-1"

  # AWS Credentials 
  access_key = "AKIA6K5V7M5MHXJ6FXX5" 
  secret_key = "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"
}