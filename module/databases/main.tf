variable "private_subnet_ids" {}

resource "aws_db_instance" "example" {
  engine            = "mysql"
  instance_class    = "db.t2.micro"
  allocated_storage = 10
  count             = 1

  # Set other necessary configurations for the database instance...

  # Omitted db_parameter_group_name, master_username, and master_password
}

resource "null_resource" "configure_db" {
  depends_on = [aws_db_instance.example]

  provisioner "local-exec" {
    command = <<EOT
      aws rds modify-db-instance \
        --db-instance-identifier ${aws_db_instance.example[0].id} \
        --db-parameter-group-name ${aws_db_parameter_group.example.name} \
        --master-username your_master_username \
        --master-user-password your_master_password
    EOT
  }
}
