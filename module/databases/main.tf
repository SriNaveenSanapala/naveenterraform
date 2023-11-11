variable "private_subnet_ids" {}
resource "aws_db_instance" "example" {
  engine               = "mysql"
  instance_class       = "db.t2.micro"
  allocated_storage    = 10
  count                = 1
  username             = "siridb"
  parameter_group_name = aws_db_parameter_group.example.name

  # other database configurations...
}

resource "aws_db_parameter_group" "example" {
  name        = "example"
  family      = "mysql8.0"
  description = "Example parameter group"
  parameters = {
    "password" = "Siri@4830"
  }
}
