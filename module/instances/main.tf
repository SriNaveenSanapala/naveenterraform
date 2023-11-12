resource "aws_instance" "example" {
  count                = 2
  ami                  = "ami-05c13eab67c5d8861"
  instance_type        = "t2.micro"
  subnet_id            = element(var.public_subnet_ids, count.index)
  #vpc_security_group_ids = [var.security_group_id] # Change to use var
  tags = {
    Name = "ExampleInstance-${count.index + 1}"
  }
}
