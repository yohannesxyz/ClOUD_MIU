resource "aws_security_group" "ec2_sg" {
  name        = "ec2-ssh-sg"
  description = "Allow SSH from anywhere"
  vpc_id      = aws_vpc.vpc1.id

  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"] # TIP: tighten this later for security
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

resource "aws_instance" "public_ec2" {
  ami                         = "ami-0c101f26f147fa7fd" # Amazon Linux 2023 (us-east-1)
  instance_type               = "t3.micro"
  subnet_id                   = aws_subnet.public_subnet1.id
  vpc_security_group_ids      = [aws_security_group.ec2_sg.id]
  key_name                    = "privateserverkey" # ⚠️ Replace this with your actual AWS key pair
  associate_public_ip_address = true

  tags = {
    Name = "public-ec2-617573"
  }
}
