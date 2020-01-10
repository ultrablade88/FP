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




