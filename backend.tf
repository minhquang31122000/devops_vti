terraform {
  backend "s3" {
    bucket = "mq-s3-bucket"
    key    = "terraform.tfstate"
    region = "ap-southeast-1"
  }
}