resource "aws_lambda_function" "this" {
  function_name = var.function_name
  role          = var.function_role_arn
  package_type  = "Image"
  image_uri     = var.image_uri
}
