variable "private_subnet_ids" {}

resource "aws_db_parameter_group" "example" {
  name        = "example"
  family      = "mysql8.0"
  description = "Example parameter group"

  parameter {
    name  = "skip_show_database"
    value = "1"
  }

  parameter {
    name  = "character_set_client"
    value = "utf8mb4"
  }

  # Add other parameters as needed
}

resource "aws_db_instance" "example" {
  engine               = "mysql"
  instance_class       = "db.t2.micro"
  allocated_storage    = 10
  count                = 1

  db_parameter_group_name = aws_db_parameter_group.example.name

  master_username = "siridb"
  master_password = "Siri@4830"

  # Set other necessary configurations for the database instance...
}
