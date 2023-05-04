# main.tf | Main Configuration

terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "4.64.0"
    }
  }

  #backend "s3" {
  #  bucket = "python-api-state-bucket"
  #  key    = "state/terraform_state.tfstate"
  #  region = "eu-west-2"
  #}
}

provider "aws" {
  region     = var.aws_region
  access_key = var.aws_access_key
  secret_key = var.aws_secret_key
  #shared_credentials_file = "$HOME/.aws/credentials"
  #profile                 = "default" 

}