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

  username             = "siridb"   # Replace with your desired username
  password             = "Siri@4830"   # Replace with your desired password
  db_parameter_group_name = aws_db_parameter_group.example.name

  # Set other necessary configurations for the database instance...

  # Omitted other parameters like db_subnet_group_name, allocated_storage, etc.
}

resource "null_resource" "configure_db" {
  depends_on = [aws_db_instance.example]

  provisioner "local-exec" {
    command = <<EOT
      aws rds modify-db-instance \
        --db-instance-identifier ${aws_db_instance.example[0].id} \
        --master-username your_master_username \
        --master-user-password your_master_password
    EOT
  }
}
