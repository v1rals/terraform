resource "aws_iam_role_policy" "test_policy" {
  name = "InDynamoDB"
  role = aws_iam_role.iam_for_lambda.id



  policy = <<-EOF
{
    "Version": "2012-10-17",
    "Statement": [
        {
            "Sid": "InDynamoDB",
            "Effect": "Allow",
            "Action": [
                "dynamodb:PutItem",
                "dynamodb:UpdateItem",
                "dynamodb:DeleteItem"
            ],
            "Resource": "arn:aws:dynamodb:us-east-1:714514121976:table/task6_s3"
        }
    ]
}
  EOF
}


resource "aws_iam_role" "iam_for_lambda" {
  name = "iam_for_s3-event_lambda"

  assume_role_policy = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Action": "sts:AssumeRole",
      "Principal": {
        "Service": "lambda.amazonaws.com"
      },
      "Effect": "Allow"
    }
  ]
}
EOF
}

resource "aws_lambda_permission" "allow_bucket" {
  statement_id  = "AllowExecutionFromS3Bucket"
  action        = "lambda:InvokeFunction"
  function_name = aws_lambda_function.func.arn
  principal     = "s3.amazonaws.com"
  source_arn    = aws_s3_bucket.bucket.arn
}



resource "aws_lambda_function" "func" {
  filename      = "./modules/task6_s3/send_event.zip"
  function_name = "send_event_to_dynamo"
  role          = aws_iam_role.iam_for_lambda.arn
  handler       = "send_event.lambda_handler"
  runtime       = "python3.6"
}


resource "aws_s3_bucket" "bucket" {
  bucket = "druzev2"
}


resource "aws_s3_bucket_notification" "bucket_notification" {
  bucket = aws_s3_bucket.bucket.id

  lambda_function {
    lambda_function_arn = aws_lambda_function.func.arn
    events              = ["s3:ObjectCreated:*"]
  }

  depends_on = [aws_lambda_permission.allow_bucket]
}
