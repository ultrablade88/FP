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

