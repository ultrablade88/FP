provider "aws" {
  region = "us-west-2"
}
resource "aws_key_pair" "KPFP" {
  key_name   = var.AWS.KEY_PAIR
  public_key = "ssh-rsa AAAAB3NzaC1yc2EAAAABJQAAAQEA6vEjPSJNs1q6mkg13W6j4dGSletxvbD6JGBa97jsO5OiRBvRferzOUldd2lQJEalf7v2Cf852kQFhLgNy30J/2pPpOHYajF5nf8TEMQfKPvoQqp7FEE1VoTasxQwe5woYv3IA8u8MVPX07O3+EaiOOjsW1le3ajgJ1nHag25Gsczhpw5w2hONBgxib0EqAxv6dDFx9VJwMpwceMdSswiWulnRSeVqp/pJKdK5DXW/ZwPYFLPxTAqkGN8LjMwfV/0q4dwMe6tgwZ0C4NcMss4OGPmXSTbAfS3NikrClfBlW9urPaaZtY74vG+qbVZqcfiF/zfC+SDJkmwssc51Q3cYQ== rsa-key-20191221"
}

variable "AWS_KEY_PAIR" {} 

resource "aws_instance" "example" {
  ami           = "ami-04590e7389a6e577c"
  instance_type = "t2.micro"
  key_name  = aws_key_pair.KPFP.key_name
}
