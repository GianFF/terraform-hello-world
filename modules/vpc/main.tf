# Red Virtual Privada (VPC)
resource "aws_vpc" "main" {
  cidr_block           = var.cidr_block # Rango de IPs privadas
  enable_dns_hostnames = true           # Habilita nombres de host DNS
  enable_dns_support   = true           # Habilita soporte DNS

  tags = {
    Name = "terraform-vpc" # Nombre descriptivo
  }
}

# Subred dentro de la VPC
# Subred 1
resource "aws_subnet" "subnet_1" {
  vpc_id            = aws_vpc.main.id
  cidr_block        = "10.0.1.0/24"
  availability_zone = "us-east-1a"

  tags = {
    Name = "terraform-vpc-subnet-1"
  }
}

# Subred 2
resource "aws_subnet" "subnet_2" {
  vpc_id            = aws_vpc.main.id
  cidr_block        = "10.0.2.0/24"
  availability_zone = "us-east-1b"

  tags = {
    Name = "terraform-vpc-subnet-2"
  }
}

# Internet Gateway
resource "aws_internet_gateway" "igw" {
  vpc_id = aws_vpc.main.id

  tags = {
    Name = "terraform-vpc-internet-gateway"
  }
}

# Route Table
resource "aws_route_table" "rt" {
  vpc_id = aws_vpc.main.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.igw.id
  }

  tags = {
    Name = "terraform-vpc-route-table"
  }
}

# Asociar la Route Table con las Subnets
resource "aws_route_table_association" "rta_1" {
  subnet_id      = aws_subnet.subnet_1.id
  route_table_id = aws_route_table.rt.id
}

resource "aws_route_table_association" "rta_2" {
  subnet_id      = aws_subnet.subnet_2.id
  route_table_id = aws_route_table.rt.id
}