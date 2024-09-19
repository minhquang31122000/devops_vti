resource "aws_s3_bucket" "b" {
  bucket = "mq-s3-bucket"
  #   acl    = "private"

  tags = {
    Name        = "My bucket"
    Environment = "Dev"
    Owner       = "Minh Quang"
  }
}
