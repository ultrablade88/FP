variable "AWS_REGION" {}

variable "AWS_SECURITY_GROUP" {}
variable "AWS_KEY_PAIR" {}

variable "AMIS" {
  type = map(string)
  default = {
    us-east-1 = "ami-00068cd7555f543d5"
    us-west-2 = "ami-0c5204531f799e0c6"
    eu-west-1 = "ami-01f14919ba412de34"
    eu-west-2 = "ami-05f37c3995fffb4fd"
    eu-west-3 = "ami-0e9e6ba6d3d38faa8"
    eu-north-1 = "ami-006cda581cf39451b"
  }
}



