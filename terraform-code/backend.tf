terraform {
  backend "s3" {
    bucket  = "clearscale-andrews"
    key     = "clearscale-andrews"
    region  = "us-east-1"
    encrypt = true
  }
}
