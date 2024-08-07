provider "aws" {
  region = local.region
}


terraform {
  required_version = ">= 1.0"

  backend "s3" {
    bucket  = "duyne-terraform-tfstate"
    key     = "global/s3/terraform.tfstate"
    region  = "ap-southeast-1"
    encrypt = true
  }

  required_providers {
    # kubectl = {
    #   source  = "gavinbunney/kubectl"
    #   version = ">= 1.14.0"
    # }
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.49"
    }
    helm = {
      source  = "hashicorp/helm"
      version = ">= 2.6.0"
    }
  }
}
