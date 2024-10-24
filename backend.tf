terraform {
  backend "s3" {
    bucket = "mq-peter-s3-bucket"
    key    = "terraform.tfstate"
    region = "ap-southeast-1"
  }
}
