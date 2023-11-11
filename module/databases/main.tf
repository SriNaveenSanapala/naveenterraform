resource "aws_db_parameter_group" "example" {
  name        = "example"
  family      = "mysql8.0"
  description = "Example parameter group"

  parameters = {
    "skip_show_database"    = "1"
    "character_set_client"  = "utf8mb4"
    "character_set_server"  = "utf8mb4"
    "collation_connection"  = "utf8mb4_unicode_ci"
    "collation_server"      = "utf8mb4_unicode_ci"
    "max_allowed_packet"    = "256M"
    "time_zone"             = "UTC"
    "wait_timeout"          = "28800"
    "master_username"       = "siridb"
    "master_password"       = "Siri@4830"
  }
}

resource "aws_db_instance" "example" {
  engine               = "mysql"
  instance_class       = "db.t2.micro"
  allocated_storage    = 10
  count                = 1

  parameter_group_name = aws_db_parameter_group.example.name

  # other database configurations...
}
