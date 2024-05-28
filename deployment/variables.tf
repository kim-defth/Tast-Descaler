# AWS Variables
variable "aws_region" {
    type = string
    default = "ap-southeast-2"
    description = "AWS Region to deploy the application to"
}

variable "aws_account_id" {
    type = string
    default = "851725343131"
    description = "Account id of the environment to deploy to, used to generate arns"
}