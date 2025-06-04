resource "aws_lambda_function" "digiequip" {
  filename      = "${path.module}/code/lambda.zip"
  function_name = var.function_name
  role          = aws_iam_role.lambda_role.arn
  handler       = "lambda_function.lambda_handler"
  runtime       = var.runtime
  timeout       = var.timeout
  memory_size   = var.memory_size
  environment {
    variables = {
      S3_BUCKET       = aws_s3_bucket.digitracking_bucket.bucket
    }
  }
}

resource "aws_s3_bucket" "digitracking_bucket" {
  bucket = "digitracking_bucket-${random_uuid.lambda_suffix.result}"
}

resource "aws_iam_role" "lambda_role" {
  name = "digiequipLambdaRole"

  assume_role_policy = jsonencode({
    Version = "2012-10-17",
    Statement = [{
      Action = "sts:AssumeRole",
      Effect = "Allow",
      Principal = {
        Service = "lambda.amazonaws.com"
      }
    }]
  })
}
