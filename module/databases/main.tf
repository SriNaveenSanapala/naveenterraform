variable "private_subnet_ids" {}
resource "aws_db_instance" "example" {
  engine               = "mysql"
  instance_class       = "db.t2.micro"
  allocated_storage    = 10
  count                = 1

  master_username = "siridb"
  master_password = "Siri@4830"

  # other database configurations...
}


  # other database configurations...

