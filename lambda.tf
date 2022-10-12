resource "aws_iam_role" "iam_for_lambda" {
  name = "iam_for_lambda"

  assume_role_policy = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Effect": "Allow",
      "Principal": {
        "Service": "lambda.amazonaws.com"
      },
      "Action": "sts:AssumeRole"
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
  handler          = "main.redirection"
  runtime          = "nodejs16.x"

  environment {
    variables = {
      INTEGRITY_CHECK =  sha256(var.integrity)
    }
  }
}

resource "aws_lambda_function_url" "main_lambda_funciton_url" {
  function_name      = aws_lambda_function.main_lambda_funciton.function_name
  authorization_type = "NONE"
}