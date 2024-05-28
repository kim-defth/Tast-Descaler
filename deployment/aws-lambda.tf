# Configuration for assuming an IAM role using web identify federation can be done using provider configuration, environment variables, 
# or a named profile in shared configuration files. In the provider, all parameters for assuming an IAM role are set in 
# the assume_role_with_web_identity block.

# Allow Lambda function to assume role
data "aws_iam_policy_document" "assume_role" {
  statement {
    effect = "Allow"

    principals {
      type        = "Service"
      identifiers = ["lambda.amazonaws.com"]
    }

    actions = ["sts:AssumeRole"]
  }
}

# Allow Lambda to assume this role
resource "aws_iam_role" "iam_for_lambda" {
  name               = "iam_for_lambda"
  assume_role_policy = data.aws_iam_policy_document.assume_role.json
}

# 
data "archive_file" "lambda" {
  type        = "zip"
  source_file = "${path.module}/../aws/lambda/simple_handler.js"
  output_path = "lambda_function_payload_simple_handler.zip"
}

# Define function to consume output file
resource "aws_lambda_function" "lambda" {
  filename      = "packaged-lambda.zip"
  function_name = "lambda_simple_handler" # AWS lambda function name
  role          = aws_iam_role.iam_for_lambda.arn
  handler       = "simple_handler.handler" # Our handler function name

  source_code_hash = data.archive_file.lambda.output_base64sha256

  runtime = "nodejs16.x" # Purposely use soon to be deprecated runtime
}

# Allow REST API gateway to invoke this function
resource "aws_lambda_permission" "apigw_lambda" {
  statement_id  = "AllowExecutionFromAPIGateway"
  action        = "lambda:InvokeFunction"
  function_name = aws_lambda_function.lambda.function_name
  principal     = "apigateway.amazonaws.com"

  # More: http://docs.aws.amazon.com/apigateway/latest/developerguide/api-gateway-control-access-using-iam-policies-to-invoke-api.html
  source_arn = "arn:aws:execute-api:${var.aws_region}:${var.aws_account_id}:${aws_api_gateway_rest_api.api.id}/*/${aws_api_gateway_method.method.http_method}${aws_api_gateway_resource.lambda.path}"
}