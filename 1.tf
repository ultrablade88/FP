provider "aws" {
  region = "us-west-2"
}

resource "aws_instance" "example" {
  ami           = "ami-062f7200baf2fa504"
  instance_type = "t2.medium"
}
