data "archive_file" "lambda_zip" {
  type        = "zip"
  source_file = "${path.module}/src/main.js"
  output_path = "${path.module}/dist/main.zip"
}
