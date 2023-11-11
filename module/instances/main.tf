variable "vpc_id" {
  default = null
}

variable "public_subnet_ids" {
  default = null
}

variable "private_subnet_ids" {
  default = null
}


# Use the variables in your instances module


resource "aws_db_instance" "example" {
  engine           = "mysql"
  instance_class   = "db.t2.micro"
  allocated_storage = 10
  count            = 1

  subnet_group_name = aws_db_subnet_group.main.name

  # other database configurations...
}

resource "aws_db_subnet_group" "main" {
  name       = "main"
  subnet_ids = var.private_subnet_ids
}
output "public_subnet_ids" {
  value = aws_subnet.public[*].id
}

output "private_subnet_ids" {
  value = aws_subnet.private[*].id
}

