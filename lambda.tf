resource "aws_iam_role" "iam_for_lambda" {
  name = "iam_for_lambda"

  assume_role_policy = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Action": "sts:AssumeRole",
      "Principal": {
        "Service": "lambda.amazonaws.com"
      },
      "Effect": "Allow",
      "Sid": ""
    }
  ]
}
EOF
}

resource "aws_lambda_function" "main_lambda_funciton" {
  filename         = "${path.module}/dist/main.zip"
  source_code_hash = filebase64sha256("${path.module}/dist/main.zip")
  function_name    = "main_lambda_function"
  role             = aws_iam_role.iam_for_lambda.arn
  handler          = "main.hello"
  runtime          = "nodejs16.x"
}

resource "aws_lambda_function_url" "main_lambda_funciton_url" {
  function_name      = aws_lambda_function.main_lambda_funciton.function_name
  authorization_type = "NONE"
}

output "output_main_lambda_funciton_url" {
  value = split("/", aws_lambda_function_url.main_lambda_funciton_url.function_url)[2]
}

output "output_main_lambda_funciton_name" {
  value = aws_lambda_function_url.main_lambda_funciton_url.function_name

}