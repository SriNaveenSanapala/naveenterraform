variable "vpc_id" {}

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
  subnet_ids = aws_subnet.private.*.id
}
