data "aws_availability_zones" "available" {
  state = "available"
}
resource "aws_iam_role_policy" "FPM_policy" {
  name = "FPM_policy"
   role = aws_iam_role.FPM_role.id

  policy = <<EOF
{
    "Version": "2012-10-17",
    "Statement": [
        {
            "Sid": "VisualEditor0",
            "Effect": "Allow",
            "Action": [
                "ec2:DescribeMovingAddresses",
                "ec2:DescribeInstances",
                "ec2:DescribeRegions",
                "ec2:DescribeDhcpOptions",
                "ec2:AssignPrivateIpAddresses",
                "ec2:DescribeVpcAttribute",
                "ec2:DescribeVpcClassicLink",
                "ec2:DescribeSecurityGroups",
                "ec2:DescribeHosts",
                "ec2:DescribeInternetGateways",
                "ec2:DescribeAvailabilityZones",
                "ec2:DescribeVpcs",
                "ec2:DescribeSubnets",
                "ec2:DescribeKeyPairs",
                "ec2:DescribeInstanceStatus",
                "ec2:DescribeEgressOnlyInternetGateways",
                "ec2:DescribeNetworkInterfaces",
                "s3:GetObject",
		"route53:GetHostedZone",
                "route53:ListHostedZones",
                "route53:ChangeResourceRecordSets"
            ],
            "Resource": "*"
        }
    ]
}
EOF
}

resource "aws_iam_role" "FPM_role"{
 name = "FPM_policy"
   assume_role_policy = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Action": "sts:AssumeRole",
      "Principal": {
        "Service": "ec2.amazonaws.com"
      },
      "Effect": "Allow",
      "Sid": ""
    }
  ]
}
EOF
}

resource "aws_iam_instance_profile" "FPM_role-instanceprofile" {
  name = "FPM_role-instanceprofile"
  role = aws_iam_role.FPM_role.name
}

resource "aws_iam_role_policy_attachment" "basic_autoscaling" {
  role       =  aws_iam_role.FPM_role.name
  policy_arn =  "arn:aws:iam::520696969576:policy/basic_autoscaling"
}
resource "aws_iam_role_policy_attachment" "SSM" {
  role       =  aws_iam_role.FPM_role.name
  policy_arn =  "arn:aws:iam::520696969576:policy/SSM"
}
resource "aws_iam_role_policy_attachment" "pass_role" {
  role       =  aws_iam_role.FPM_role.name
  policy_arn =  "arn:aws:iam::520696969576:policy/pass_role"
}
resource "aws_iam_role_policy_attachment" "ASGRP" {
  role       =  aws_iam_role.FPM_role.name
  policy_arn =  "arn:aws:iam::520696969576:policy/ASGRP"
}
resource "aws_iam_role_policy_attachment" "IAM" {
  role       =  aws_iam_role.FPM_role.name
  policy_arn =  "arn:aws:iam::520696969576:policy/IAM"
}
resource "aws_iam_role_policy" "FPW_policy" {
  name = "FPW_policy"
   role = aws_iam_role.FPW_role.id

  policy = <<EOF
{
    "Version": "2012-10-17",
    "Statement": [
        {
            "Sid": "VisualEditor0",
            "Effect": "Allow",
            "Action": [
               "ec2:DescribeInstances",
                "ec2:DescribeNetworkInterfaces",
                "ec2:DescribeAvailabilityZones",
                "ec2:DescribeVpcs",
                "ec2:DescribeRegions",
                "ssm:GetParameters",
                "ec2:DescribeSubnets",
                "ec2:DescribeKeyPairs",
                "ssm:GetParameter",
                "ec2:DescribeSecurityGroups",
                "s3:GetObject",
		"autoscaling:AttachInstances",
		"route53:GetHostedZone",
                "route53:ListHostedZones",
                "route53:ChangeResourceRecordSets"
            ],
            "Resource": "*"
        }
    ]
}
EOF
}

resource "aws_iam_role" "FPW_role"{
 name = "FPW_policy"
   assume_role_policy = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Action": "sts:AssumeRole",
      "Principal": {
        "Service": "ec2.amazonaws.com"
      },
      "Effect": "Allow",
      "Sid": ""
    }
  ]
}
EOF
}
resource "aws_iam_instance_profile" "FPW_role-instanceprofile" {
  name = "FPW_role-instanceprofile"
  role = aws_iam_role.FPW_role.name
}
resource "aws_instance" "DSH1" {
  ami           =  var.AMIS[var.AWS_REGION]
  instance_type = "t2.micro"

  # the VPC subnet
  subnet_id = aws_subnet.FP-public-1.id

  # the security group
  vpc_security_group_ids = [aws_security_group.SGFP.id]

  # the public SSH key
  key_name = aws_key_pair.KPFP.key_name

  # userdata
  user_data= file("DSH1.sh")

  # role:
  iam_instance_profile = aws_iam_instance_profile.FPM_role-instanceprofile.name

  # private ip
  #private_ip= "172.20.0.11"


  tags = {
    Name = "DSH1"
  }
}
resource "aws_instance" "DSH2" {
  ami           =  var.AMIS[var.AWS_REGION]
  instance_type = "t2.micro"

  # the VPC subnet
  subnet_id = aws_subnet.FP-public-1.id

  # the security group
  vpc_security_group_ids = [aws_security_group.SGFP.id]

  # the public SSH key
  key_name = aws_key_pair.KPFP.key_name

  # userdata
  user_data= file("DSH2.sh")

  # role:
  iam_instance_profile = aws_iam_instance_profile.FPM_role-instanceprofile.name

  # private ip
  #private_ip= "172.20.0.12"


  tags = {
    Name = "DSH2"
  }
}
resource "aws_instance" "DSW1" {
  ami           =  var.AMIS[var.AWS_REGION]
  instance_type = "t2.micro"

  # the VPC subnet
  subnet_id = aws_subnet.FP-public-1.id

  # the security group
  vpc_security_group_ids = [aws_security_group.SGFP.id]

  # the public SSH key
  key_name = aws_key_pair.KPFP.key_name

  # userdata
  user_data= file("DSW1.sh")

  # role:
  iam_instance_profile = aws_iam_instance_profile.FPM_role-instanceprofile.name

  # private ip
  #private_ip= "172.20.0.21"


  tags = {
    Name = "DSW1"
  }
}
resource "aws_instance" "DSW2" {
  ami           =  var.AMIS[var.AWS_REGION]
  instance_type = "t2.micro"

  # the VPC subnet
  subnet_id = aws_subnet.FP-public-1.id

  # the security group
  vpc_security_group_ids = [aws_security_group.SGFP.id]

  # the public SSH key
  key_name = aws_key_pair.KPFP.key_name

  # userdata
  user_data= file("DSW2.sh")

  # role:
  iam_instance_profile = aws_iam_instance_profile.FPW_role-instanceprofile.name

  # private ip
  #private_ip= "172.20.0.22"


  tags = {
    Name = "DSW2"
  }
}
resource "aws_instance" "DSW3" {
  ami           =  var.AMIS[var.AWS_REGION]
  instance_type = "t2.micro"

  # the VPC subnet
  subnet_id = aws_subnet.FP-public-1.id

  # the security group
  vpc_security_group_ids = [aws_security_group.SGFP.id]

  # the public SSH key
  key_name = aws_key_pair.KPFP.key_name

  # userdata
  user_data= file("DSW3.sh")

  # role:
  iam_instance_profile = aws_iam_instance_profile.FPW_role-instanceprofile.name

  # private ip
  #private_ip= "172.20.0.23"


  tags = {
    Name = "DSW3"
  }
}
resource "aws_key_pair" "KPFP" {
  key_name   = var.AWS_KEY_PAIR
  public_key = "ssh-rsa AAAAB3NzaC1yc2EAAAABJQAAAQEA6vEjPSJNs1q6mkg13W6j4dGSletxvbD6JGBa97jsO5OiRBvRferzOUldd2lQJEalf7v2Cf852kQFhLgNy30J/2pPpOHYajF5nf8TEMQfKPvoQqp7FEE1VoTasxQwe5woYv3IA8u8MVPX07O3+EaiOOjsW1le3ajgJ1nHag25Gsczhpw5w2hONBgxib0EqAxv6dDFx9VJwMpwceMdSswiWulnRSeVqp/pJKdK5DXW/ZwPYFLPxTAqkGN8LjMwfV/0q4dwMe6tgwZ0C4NcMss4OGPmXSTbAfS3NikrClfBlW9urPaaZtY74vG+qbVZqcfiF/zfC+SDJkmwssc51Q3cYQ== rsa-key-20191221"
}

# nat gw
resource "aws_eip" "nat" {
  vpc = true
}

resource "aws_nat_gateway" "FP-nat-gw" {
  allocation_id = aws_eip.nat.id
  subnet_id     = aws_subnet.FP-public-1.id
  depends_on    = [aws_internet_gateway.FP-gw]
}

# VPC setup for NAT
resource "aws_route_table" "FP-private" {
  vpc_id = aws_vpc.FP.id
  route {
    cidr_block     = "0.0.0.0/0"
    nat_gateway_id = aws_internet_gateway.FP-gw.id
  }

  tags = {
    Name = "FP-private-1"
  }
}
# route associations private
resource "aws_route_table_association" "FP-private-1-a" {
  subnet_id      = aws_subnet.FP-private-1.id
  route_table_id = aws_route_table.FP-private.id
}

resource "aws_route_table_association" "FP-private-2-a" {
  subnet_id      = aws_subnet.FP-private-2.id
  route_table_id = aws_route_table.FP-private.id
}

resource "aws_route_table_association" "FP-private-3-a" {
  subnet_id      = aws_subnet.FP-private-3.id
  route_table_id = aws_route_table.FP-private.id
}

provider "aws" {
  access_key = var.AWS_ACCESS_KEY
  secret_key = var.AWS_SECRET_KEY
  region     = var.AWS_REGION
}
resource "aws_route53_zone" "FP" {
  name = "FP.Phz"

  vpc {
    vpc_id = aws_vpc.FP.id
  }
}

resource "aws_route53_record" "DSH1" {
  zone_id = aws_route53_zone.FP.zone_id
  name    = "DSH1.FP.Phz"
  type    = "A"
  ttl     = "300"
  records = ["172.20.0.11"]
}
resource "aws_route53_record" "DSH2" {
  zone_id = aws_route53_zone.FP.zone_id
  name    = "DSH2.FP.Phz"
  type    = "A"
  ttl     = "300"
  records = ["172.20.0.12"]
}
resource "aws_route53_record" "DSW1" {
  zone_id = aws_route53_zone.FP.zone_id
  name    = "DSW1.FP.Phz"
  type    = "A"
  ttl     = "300"
  records = ["172.20.0.21"]
}
resource "aws_route53_record" "DSW2" {
  zone_id = aws_route53_zone.FP.zone_id
  name    = "DSW2.FP.Phz"
  type    = "A"
  ttl     = "300"
  records = ["172.20.0.22"]
}
resource "aws_route53_record" "DSW3" {
  zone_id = aws_route53_zone.FP.zone_id
  name    = "DSW3.FP.Phz"
  type    = "A"
  ttl     = "300"
  records = ["172.20.0.23"]
}
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

resource "aws_lb_target_group" "DSH" {
  name        = "DSH-TargetGroup"
  depends_on  = [aws_vpc.FP]
  port        = 80
  protocol    = "HTTP"
  vpc_id      = aws_vpc.FP.id
  target_type = "instance"

}

resource "aws_lb_target_group" "DSW" {
  name        = "DSW-TargetGroup"
  depends_on  = [aws_vpc.FP]
  port        = 80
  protocol    = "HTTP"
  vpc_id      = aws_vpc.FP.id
  target_type = "instance"

}
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



# Internet VPC
resource "aws_vpc" "FP" {
  cidr_block           =  "172.20.0.0/20"
  instance_tenancy     = "default"
  enable_dns_support   = "true"
  enable_dns_hostnames = "true"
  enable_classiclink   = "false"
  tags = {
    Name = "FP"
  }
}
# Subnets
resource "aws_subnet" "FP-public-1" {
  vpc_id                  = aws_vpc.FP.id
  cidr_block              = cidrsubnet("172.20.0.0/20",4,0)
  map_public_ip_on_launch = "true"
  availability_zone = data.aws_availability_zones.available.names[0]

  tags = {
    Name = "FP-public-1"
  }
}

resource "aws_subnet" "FP-public-2" {
  vpc_id                  = aws_vpc.FP.id
  cidr_block              = cidrsubnet("172.20.0.0/20",4,1)
  map_public_ip_on_launch = "true"
  availability_zone = data.aws_availability_zones.available.names[1]

  tags = {
    Name = "FP-public-2"
  }
}

resource "aws_subnet" "FP-public-3" {
  vpc_id                  = aws_vpc.FP.id
  cidr_block              = cidrsubnet("172.20.0.0/20",4,2)
  map_public_ip_on_launch = "true"
  availability_zone = data.aws_availability_zones.available.names[2]

  tags = {
    Name = "FP-public-3"
  }
}
resource "aws_subnet" "FP-private-1" {
  vpc_id                  = aws_vpc.FP.id
  cidr_block              = cidrsubnet("172.20.0.0/20",4,3)
  map_public_ip_on_launch = "false"
  availability_zone       = data.aws_availability_zones.available.names[0]


  tags = {
    Name = "FP-private-1"
  }
}

resource "aws_subnet" "FP-private-2" {
  vpc_id                  = aws_vpc.FP.id
  cidr_block              = cidrsubnet("172.20.0.0/20",4,4)
  map_public_ip_on_launch = "false"
  availability_zone       = data.aws_availability_zones.available.names[1]

  tags = {
    Name = "FP-private-2"
  }
}

resource "aws_subnet" "FP-private-3" {
  vpc_id                  = aws_vpc.FP.id
  cidr_block              = cidrsubnet("172.20.0.0/20",4,5)
  map_public_ip_on_launch = "false"
  availability_zone       = data.aws_availability_zones.available.names[2]

  tags = {
    Name = "FP-private-3"
  }
}
# Internet GW
resource "aws_internet_gateway" "FP-gw" {
  vpc_id = aws_vpc.FP.id

  tags = {
    Name = "FP"
  }
}

# route tables
resource "aws_route_table" "FP-public" {
  vpc_id = aws_vpc.FP.id
  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.FP-gw.id
  }

  tags = {
    Name = "FP-public-1"
  }
}

# route associations public
resource "aws_route_table_association" "FP-public-1-a" {
  subnet_id      = aws_subnet.FP-public-1.id
  route_table_id = aws_route_table.FP-public.id
}

resource "aws_route_table_association" "FP-public-2-a" {
  subnet_id      = aws_subnet.FP-public-2.id
  route_table_id = aws_route_table.FP-public.id
}

resource "aws_route_table_association" "FP-public-3-a" {
  subnet_id      = aws_subnet.FP-public-3.id
  route_table_id = aws_route_table.FP-public.id
}




