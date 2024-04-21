module "label" {
  source   = "cloudposse/label/null"
  version = "0.25.0"
  name = var.name
  context = var.context
}

module "cors" {
  source = "squidfunk/api-gateway-enable-cors/aws"
  version = "0.3.3"
  api_id          = var.aws_api_gateway_rest_api.id
  api_resource_id = aws_api_gateway_resource.this.id
}
resource "aws_lambda_permission" "this" {
  statement_id  = "AllowExecutionFromAPIGateWay"
  action        = "lambda:InvokeFunction"
  function_name =  var.lambda_function_name
  principal     = "apigateway.amazonaws.com"
  source_arn    = "${var.aws_api_gateway_rest_api.execution_arn}/*/${var.method_type}${aws_api_gateway_resource.this.path}"
}

resource "aws_api_gateway_resource" "this" {
    rest_api_id = var.aws_api_gateway_rest_api.id
    parent_id = var.aws_api_gateway_rest_api.root_resource_id
    path_part = var.path_part
}

resource "aws_api_gateway_method" "this" {
    rest_api_id   = var.aws_api_gateway_rest_api.id
    resource_id   = aws_api_gateway_resource.this.id
    http_method   = var.method_type
    authorization = "NONE"
}

resource "aws_api_gateway_integration" "this" {
    rest_api_id = var.aws_api_gateway_rest_api.id
    resource_id = aws_api_gateway_resource.this.id
    http_method = aws_api_gateway_method.this.http_method
    integration_http_method = "POST"
    type = "AWS"
    uri = var.lambda_invoke_arn
    request_parameters = {"integration.request.header.X-Authorization" = "'static'"}
    request_templates = {
        "application/xml" = <<EOF
        {
            "body" : $inpost.json('$')
        }
        EOF
    }
    content_handling = "CONVERT_TO_TEXT"
}

resource "aws_api_gateway_method_response" "this" {
    rest_api_id = var.aws_api_gateway_rest_api.id
    resource_id = aws_api_gateway_resource.this.id
    http_method = aws_api_gateway_method.this.http_method
    status_code = "200"
    response_models = {"application/json" = "Empty"}
    response_parameters = {
      "method.response.header.Access-Control-Allow-Headers" = true,
      "method.response.header.Access-Control-Allow-Methods" = true,
      "method.response.header.Access-Control-Allow-Origin" = false
    }
}

resource "aws_api_gateway_integration_response" "this" {
    rest_api_id = var.aws_api_gateway_rest_api.id
    resource_id = aws_api_gateway_resource.this.id
    http_method = aws_api_gateway_method.this.http_method
    status_code = aws_api_gateway_method_response.this.status_code
    response_parameters = {
      "method.response.header.Access-Control-Allow-Headers" = "'Content-Type,X-Amz-Date,Authorization,X-Api-Key,X-Amz-Security-Token'",
      "method.response.header.Access-Control-Allow-Methods" = "'POST,OPTIONS,GET,PUT,PATCH,DELETE'",
      "method.response.header.Access-Control-Allow-Origin" = "'*'"
    }
}