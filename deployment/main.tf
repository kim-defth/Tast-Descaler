# Base Terraform script from https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/lambda_function

# Docs
# Terraform https://registry.terraform.io/providers/hashicorp/aws/latest/docs
# Assume IAM Role with OIDC https://docs.aws.amazon.com/cli/latest/userguide/cli-configure-role.html#cli-configure-role-oidc
# ^ https://aws.amazon.com/blogs/security/use-iam-roles-to-connect-github-actions-to-actions-in-aws/

terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.0"
    }
  }

  # Terraform state saved to S3 bucket. 
  backend "s3" {
    bucket = "descalr-poc-terraform"
    key    = "terraform/state"
    region = "ap-southeast-2"
  }
}

# Configure the AWS Provider
provider "aws" {
  region = "ap-southeast-2"
}