terraform {
    cloud  {
        organization = "jeramaya-gramby"
        hostname = "app.terraform.io" 

    workspaces {
      name = "production_example"
      
      tags = {
        Name = "production-example-workspace"
            }
        }
    }
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 4.16"
    }
  }

  required_version = ">= 1.2.0"
}

provider "aws" {
  region  = "us-east-1"
}
