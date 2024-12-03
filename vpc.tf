provider "aws" {
  region = "us-east-1"
}

resource "aws_vpc" "one" {
  tags = {
    Name = "terraform-vpc"
  }
  instance_tenancy     = "default"
  cidr_block           = "100.0.0.0/16"
  enable_dns_hostnames = "true"
}

resource "aws_subnet" "two" {
  tags = {
    Name = "terraform-subnet"
  }
  vpc_id                  = aws_vpc.one.id
  availability_zone       = "us-east-1c"
  cidr_block              = "100.0.0.0/24"
  map_public_ip_on_launch = "true"
}

resource "aws_internet_gateway" "three" {
  tags = {
    Name = "terraform-internetgateway"
  }
  vpc_id = aws_vpc.one.id
}

resource "aws_route_table" "four" {
  tags = {
    Name = "terraform-routetable"
  }
  vpc_id = aws_vpc.one.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.three.id
  }
}

resource "aws_route_table_association" "five" {
  subnet_id      = aws_subnet.two.id
  route_table_id = aws_route_table.four.id
}

