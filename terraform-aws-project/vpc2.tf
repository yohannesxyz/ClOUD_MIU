resource "aws_vpc" "vpc2" {
  cidr_block = "10.1.0.0/16"
  tags = {
    Name = "vpc-2-617573"
  }
}

resource "aws_subnet" "private_subnet1" {
  vpc_id                  = aws_vpc.vpc2.id
  cidr_block              = "10.1.1.0/24"
  availability_zone       = "us-east-1d"
  map_public_ip_on_launch = false

  tags = {
    Name = "private-subnet-1-617573"
  }
}

resource "aws_subnet" "private_subnet2" {
  vpc_id                  = aws_vpc.vpc2.id
  cidr_block              = "10.1.2.0/24"
  availability_zone       = "us-east-1e"
  map_public_ip_on_launch = false

  tags = {
    Name = "private-subnet-2-617573"
  }
}
