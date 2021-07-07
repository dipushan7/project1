provider "aws" {
  region     = "us-east-2"
  access_key = var.my_access_key
  secret_key = var.my_secret_key

}

resource "aws_vpc" "myNewVPC" {
  cidr_block           = "10.0.0.0/16"
  enable_dns_support   = true
  enable_dns_hostnames = true
  enable_classiclink   = false
  instance_tenancy     = "default"

  tags = {
    Name = "myNewVPC"
  }
}

resource "aws_subnet" "myvpcpublicsubnet1" {
  vpc_id                  = aws_vpc.myNewVPC.id
  cidr_block              = "10.0.101.0/24"
  map_public_ip_on_launch = true
  availability_zone       = "us-east-2a"
  tags = {
    Name = "myvpcpublicsubnet1"
  }
}
resource "aws_subnet" "myvpcpublicsubnet2" {
  vpc_id            = aws_vpc.myNewVPC.id
  cidr_block        = "10.0.102.0/24"
  availability_zone = "us-east-2a"
  tags = {
    Name = "myvpcpublicsubnet2"
  }
}
resource "aws_subnet" "myvpcprivatesubnet1" {
  vpc_id            = aws_vpc.myNewVPC.id
  cidr_block        = "10.0.1.0/24"
  availability_zone = "us-east-2a"
  tags = {
    Name = "myvpcprivatesubnet1"
  }
}
resource "aws_subnet" "myvpcprivatesubnet2" {
  vpc_id            = aws_vpc.myNewVPC.id
  cidr_block        = "10.0.2.0/24"
  availability_zone = "us-east-2a"
  tags = {
    Name = "myvpcprivatesubnet2"
  }
}

resource "aws_internet_gateway" "myvpcigw" {
  vpc_id = aws_vpc.myNewVPC.id
  tags = {
    Name = "myvpcigw_new"
  }
}

resource "aws_route_table" "myvpcroutetable" {
  vpc_id = aws_vpc.myNewVPC.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.myvpcigw.id
  }

  tags = {
    Name = "myvpcroutetable"
  }
}
