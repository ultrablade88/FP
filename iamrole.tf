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
