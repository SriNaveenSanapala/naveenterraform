resource "aws_instance" "example" {
  count                = 2
  ami                  = "ami-05c13eab67c5d8861"
  instance_type        = "t2.micro"
  subnet_id            = element(var.public_subnet_ids, count.index)
  security_group_ids   = [module.security.security_group_id]
  tags = {
    Name = "ExampleInstance-${count.index + 1}"
  }
}
