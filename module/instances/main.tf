module "security" {
  source = "../security"
  vpc_id = var.vpc_id
}


resource "aws_instance" "example" {
  count         = 2
  ami           = "ami-0c55b159cbfafe1f0"
  instance_type = "t2.micro"

  subnet_id = var.create_internet_gateway ? module.network.public_subnet_ids[count.index] : module.network.private_subnet_ids[count.index]

  vpc_security_group_ids = var.create_security_group ? [module.security.security_group_id] : []

  tags = {
    Name = "ExampleInstance-${count.index + 1}"
  }
}
