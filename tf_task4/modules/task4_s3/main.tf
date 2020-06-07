resource "aws_s3_bucket" "3" {
  bucket = "druzev2"
  acl    = "private"

  tags = {
    Name        = "task4_s3"
    Environment = "Task4"
  }
}
