resource "aws_vpc_peering_connection" "peer" {
  vpc_id        = aws_vpc.vpc1.id
  peer_vpc_id   = aws_vpc.vpc2.id
  auto_accept   = true

  tags = {
    Name = "vpc-peer-617573"
  }
}

# 🔄 VPC 1 → VPC 2
resource "aws_route" "vpc1_to_vpc2" {
  route_table_id         = aws_route_table.rtb1.id
  destination_cidr_block = aws_vpc.vpc2.cidr_block
  vpc_peering_connection_id = aws_vpc_peering_connection.peer.id
}

# 🛣 VPC 2 → VPC 1 (need separate route table for private subnets)
resource "aws_route_table" "vpc2_rt" {
  vpc_id = aws_vpc.vpc2.id

  tags = {
    Name = "rtb-vpc2-peering"
  }
}

resource "aws_route" "vpc2_to_vpc1" {
  route_table_id         = aws_route_table.vpc2_rt.id
  destination_cidr_block = aws_vpc.vpc1.cidr_block
  vpc_peering_connection_id = aws_vpc_peering_connection.peer.id
}

resource "aws_route_table_association" "private_rt_assoc1" {
  subnet_id      = aws_subnet.private_subnet1.id
  route_table_id = aws_route_table.vpc2_rt.id
}

resource "aws_route_table_association" "private_rt_assoc2" {
  subnet_id      = aws_subnet.private_subnet2.id
  route_table_id = aws_route_table.vpc2_rt.id
}
