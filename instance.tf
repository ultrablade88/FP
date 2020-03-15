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
