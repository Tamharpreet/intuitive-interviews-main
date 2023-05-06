terraform {
  backend "s3" {
    bucket = "MyBucket"
    key    = "path/to/your/key"
    region = "us-east-1"
  }
}
