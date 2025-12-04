
resource "aws_vpc" "main" {
  cidr_block           = "10.0.0.0/16"  # 65,000 IPs
  enable_dns_support   = true
  enable_dns_hostnames = true

  tags = {
    Name = "devops-bootcamp-vpc"
  }
}


resource "aws_subnet" "public" {
  vpc_id                  = aws_vpc.main.id
  cidr_block              = "10.0.1.0/24"  # 256 IPs
  map_public_ip_on_launch = true           
  availability_zone       = "ap-south-1a"

  tags = {
    Name = "public-subnet"
  }
}

resource "aws_subnet" "private" {
  vpc_id            = aws_vpc.main.id
  cidr_block        = "10.0.2.0/24"
  availability_zone = "ap-south-1a"

  tags = {
    Name = "private-subnet"
  }
}


resource "aws_internet_gateway" "gw" {
  vpc_id = aws_vpc.main.id

  tags = {
    Name = "main-gateway"
  }
}

resource "aws_route_table" "public_rt" {
  vpc_id = aws_vpc.main.id

  route {
    cidr_block = "0.0.0.0/0"             
    gateway_id = aws_internet_gateway.gw.id 
  }

  tags = {
    Name = "public-route-table"
  }
}

resource "aws_route_table_association" "a" {
  subnet_id      = aws_subnet.public.id
  route_table_id = aws_route_table.public_rt.id
}
# Secondary Private Subnet (For High Availability)
resource "aws_subnet" "private_b" {
  vpc_id            = aws_vpc.main.id
  cidr_block        = "10.0.3.0/24"
  availability_zone = "ap-south-1b"  # <--- Note the 'b'

  tags = {
    Name = "private-subnet-b"
  }
}
