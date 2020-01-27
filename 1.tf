provider "aws" {
  region = "us-west-2"
}

resource "aws_instance" "example" {
  ami           = "ami-04590e7389a6e577c"
  instance_type = "t2.medium"
}
