variable "vpc_id" {}
variable "private_subnet_ids" {}

resource "aws_db_subnet_group" "main" {
  name       = "main"
  subnet_ids = var.private_subnet_ids
}

resource "aws_db_instance" "example" {
  engine            = "mysql"
  instance_class    = "db.t2.micro"
  allocated_storage = 10
  count             = 1
  username = "siridb"

  # Remove the line below
  # subnet_group_name = aws_db_subnet_group.main.name

  # other database configurations...
}
