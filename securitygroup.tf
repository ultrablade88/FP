resource "aws_security_group" "SGFP"{
  vpc_id = aws_vpc.FP.id
  name = var.AWS_SECURITY_GROUP
  description = "SG for the Final Project in DevOps"
  egress {
    from_port = 0
    to_port = 0
    protocol = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
  ingress {
    from_port = 22
    to_port = 22
    protocol = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
  ingress {
    from_port = 80
    to_port = 80
    protocol = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
  ingress {
    from_port = 8080
    to_port = 8080
    protocol = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
    ingress {
    from_port = 0
    to_port = 0
    protocol = "icmp"
    cidr_blocks = ["0.0.0.0/0"]
  }
     ingress {
    from_port = 2377
    to_port = 2377
    protocol = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
   ingress {
      from_port = 4789
      to_port = 4789
       protocol = "udp"
       cidr_blocks = ["0.0.0.0/0"]
    }
 ingress {
      from_port = 7946
      to_port = 7946
       protocol = "udp"
       cidr_blocks = ["0.0.0.0/0"]
    }
ingress {
      from_port = 7946
      to_port = 7946
       protocol = "tcp"
       cidr_blocks = ["0.0.0.0/0"]
    }
ingress {
      from_port = 9090 
      to_port = 9090
       protocol = "tcp"
       cidr_blocks = ["0.0.0.0/0"]
    }
ingress {
      from_port = 3000
      to_port = 3000
       protocol = "tcp"
       cidr_blocks = ["0.0.0.0/0"]
    }
    ingress {
      from_port = 9093
      to_port = 9093
       protocol = "tcp"
       cidr_blocks = ["0.0.0.0/0"]
    }
    ingress {
      from_port = 9094
      to_port = 9094
       protocol = "tcp"
       cidr_blocks = ["0.0.0.0/0"]
    }



  tags = {
    Name = "SG"
  }
}

