# 1. Define the Provider
terraform {
  required_version = ">= 1.0.0"
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.0"
    }
  }

  backend "s3" {
    bucket         = "my-minecraft-state-123" # The bucket you created in Step 2
    key            = "minecraft/terraform.tfstate"
    region         = "ca-central-1"
    dynamodb_table = "terraform-lock-table"
  }
}

provider "aws" {
  region  = "ca-central-1"
  profile = var.is_pipeline ? null : "terraform-local"
}