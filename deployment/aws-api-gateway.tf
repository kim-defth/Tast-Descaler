# https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/api_gateway_rest_api

# API Gateway
resource "aws_api_gateway_rest_api" "api" {
  name = "descalrapi"
}

# /lambda
resource "aws_api_gateway_resource" "lambda" {
  path_part   = "lambda"
  parent_id   = aws_api_gateway_rest_api.api.root_resource_id
  rest_api_id = aws_api_gateway_rest_api.api.id
}

# Add method to the /lambda resource
resource "aws_api_gateway_method" "method" {
  rest_api_id   = aws_api_gateway_rest_api.api.id
  resource_id   = aws_api_gateway_resource.lambda.id
  http_method   = "GET"
  authorization = "NONE"
}

# Add Lambda integration to method GET /lambda
resource "aws_api_gateway_integration" "integration" {
  rest_api_id             = aws_api_gateway_rest_api.api.id
  resource_id             = aws_api_gateway_resource.lambda.id
  http_method             = aws_api_gateway_method.method.http_method
  integration_http_method = "POST"
  type                    = "AWS_PROXY"
  uri                     = aws_lambda_function.lambda.invoke_arn
}