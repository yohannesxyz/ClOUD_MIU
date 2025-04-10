resource "aws_db_subnet_group" "rds_subnets" {
  name       = "mysql-db-subnet-group-617573"
  subnet_ids = [
    aws_subnet.private_subnet1.id,
    aws_subnet.private_subnet2.id
  ]
  tags = {
    Name = "mysql-db-subnet-group-617573"
  }
}

resource "aws_security_group" "rds_sg" {
  name        = "rds-mysql-sg-617573"
  description = "Allow MySQL from VPC 1"
  vpc_id      = aws_vpc.vpc2.id

  ingress {
    from_port   = 3306
    to_port     = 3306
    protocol    = "tcp"
    cidr_blocks = ["10.0.0.0/16"] # VPC 1 CIDR block
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

resource "aws_db_instance" "mysql_rds" {
  identifier              = "mysql-db-617573"
  db_name                 = "mysqldb617573"
  engine                  = "mysql"
  engine_version          = "5.7"
  instance_class          = "db.t3.micro"
  allocated_storage       = 20
  username                = "admin"
  password                = var.db_password
  db_subnet_group_name    = aws_db_subnet_group.rds_subnets.name
  vpc_security_group_ids  = [aws_security_group.rds_sg.id]
  publicly_accessible     = false
  backup_retention_period = 1
  skip_final_snapshot     = true
  tags = {
    Name = "mysql-db-617573"
  }
}
