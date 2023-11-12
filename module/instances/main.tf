module "security" {
  source = "../security"
  vpc_id = var.vpc_id
}

resource "aws_instance" "example" {
  count                = 2
  ami                  = "ami-0fc5d935ebf8bc3bc"
  instance_type        = "t2.micro"
  subnet_id            = element(var.public_subnet_ids, count.index)
  vpc_security_group_ids = [module.security.security_group_id]

  tags = {
    Name = "ExampleInstance-${count.index + 1}"
  }
}
