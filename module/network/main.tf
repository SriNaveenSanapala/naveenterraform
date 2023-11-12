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
  count                   = length(var.public_subnet_names)
  vpc_id                  = aws_vpc.main[0].id
  cidr_block              = "10.0.${count.index + 1}.0/24"
  availability_zone       = element(var.availability_zones, count.index)
  map_public_ip_on_launch = true
  tags = {
    Name = var.public_subnet_names[count.index]
  }
}

resource "aws_subnet" "private" {
  count                   = 1
  vpc_id                  = aws_vpc.main[0].id
  cidr_block              = "10.0.3.0/24"
  availability_zone       = element(var.availability_zones, 0)
  map_public_ip_on_launch = false
  tags = {
    Name = "private-subnet-1"
  }
}

resource "aws_internet_gateway" "main" {
  count = var.create_internet_gateway ? 1 : 0
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
    gateway_id = var.create_internet_gateway ? aws_internet_gateway.main[0].id : null
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

resource "null_resource" "dependency" {
  count = var.create_internet_gateway ? length(var.public_subnet_names) : 0

  provisioner "local-exec" {
    command = "echo This is a dependency for subnet ${var.public_subnet_names[count.index]}"
  }

  depends_on = [null_resource.dummy]
}
