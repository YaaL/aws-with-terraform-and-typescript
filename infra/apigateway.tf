 data "template_file" "aws_api_swagger" {
  template = file("../api.yml")
}

resource "aws_api_gateway_rest_api" "api" {
  name = "api-${var.environment}"
  body = data.template_file.aws_api_swagger.rendered
}

resource "aws_api_gateway_stage" "api_gateway_stage" {
  stage_name =  var.environment
  rest_api_id = aws_api_gateway_rest_api.api.id
  deployment_id = aws_api_gateway_deployment.api_gateway_deployment.id
}

resource "aws_api_gateway_deployment" "api_gateway_deployment" {
  rest_api_id = aws_api_gateway_rest_api.api.id

  triggers = {
    redeployment = sha1(jsonencode(aws_api_gateway_rest_api.api.body))
  }

  lifecycle {
    create_before_destroy = true
  }
}
