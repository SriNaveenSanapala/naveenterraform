# ./module/network/main.tf

resource "aws_vpc" "main" {
  count = 1

  cidr_block          = var.vpc_cidr_block
  enable_dns_support  = true
  enable_dns_hostnames = true
  tags = {
    Name = var.vpc_name
  }
}

resource "aws_subnet" "public" {
  vpc_id                  = aws_vpc.main[0].id
  cidr_block              = "10.0.1.0/24"
  availability_zone       = element(var.availability_zones, 0)
  map_public_ip_on_launch = true
  tags = {
    Name = "public-subnet-1"
  }
}

resource "aws_subnet" "private" {
  vpc_id                  = aws_vpc.main[0].id
  cidr_block              = "10.0.3.0/24"
  availability_zone       = element(var.availability_zones, 0)
  map_public_ip_on_launch = false
  tags = {
    Name = "private-subnet-1"
  }
}


resource "aws_internet_gateway" "main" {
  count = 1
  vpc_id = aws_vpc.main[0].id
  tags = {
    Name = var.igw_name
  }
}

resource "aws_route_table" "public" {
  count = 1
  vpc_id = aws_vpc.main[0].id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.main[0].id
  }

  tags = {
    Name = var.public_route_table_name
  }
}

resource "aws_route_table" "private" {
  count = 1
  vpc_id = aws_vpc.main[0].id
  tags = {
    Name = var.private_route_table_name
  }
}

resource "aws_route_table_association" "public_subnet_association" {
  count          = 1
  subnet_id      = aws_subnet.public.id  # Remove [0] index
  route_table_id = aws_route_table.public[0].id
  depends_on     = [aws_route_table.public[0]]
}

resource "aws_route_table_association" "private_subnet_association" {
  count          = 1
  subnet_id      = aws_subnet.private.id  # Remove [0] index
  route_table_id = aws_route_table.private[0].id
  depends_on     = [aws_route_table.private[0]]
}
